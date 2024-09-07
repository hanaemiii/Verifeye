import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/bloc/account_bloc/account_state.dart';
import 'package:verifeye/core/firebase_services/firebase_storage.dart';
import 'package:verifeye/core/firebase_services/firestore_database.dart';
import 'package:verifeye/core/forms/change_name_form.dart';
import 'package:verifeye/helpers/functions/generate_image_name.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc()
      : super(
          AccountState(
            form: ChangeNameForm(),
            loading: false,
          ),
        ) {
    on<GetUserInfoEvent>(getUserInfo);
    on<UserDataEvent>(userData);
    on<ChooseProfilePhotoEvent>(chooseProfilePhoto);
    on<OpenCameraEvent>(openCamera);
    on<TakePictureEvent>(takePicture);
    on<SendPhotoToStorageEvent>(sendPhotoToStorage);
    on<DeletePhotoEvent>(deletePhoto);
    on<ChangeNameEvent>(changeName);
    on<ClearStateFileEvent>(clearStateFile);
    on<ResetAccountPageEvent>(resetAccountPage);
  }
  final FirestoreDatabaseService firestoreDatabaseService =
      GetIt.I<FirestoreDatabaseService>();
  final FirebaseStorageService firebaseStorageService =
      GetIt.I<FirebaseStorageService>();
  GenerateImageName generateImageName = GenerateImageName();

  getUserInfo(GetUserInfoEvent event, Emitter<AccountState> emit) {
    firestoreDatabaseService.getCurrentUser().listen(
      (user) {
        add(
          UserDataEvent(user),
        );
      },
    );
  }

  userData(UserDataEvent event, Emitter<AccountState> emit) {
    emit(
      state.copyWith(
        user: event.user,
      ),
    );
  }

  Future<void> chooseProfilePhoto(
      ChooseProfilePhotoEvent event, Emitter<AccountState> emit) async {
    // pick image from gallery
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File imageFile = File(image.path);
      emit(
        state.copyWith(
          file: imageFile,
        ),
      );
    }
  }

  Future<void> openCamera(
      OpenCameraEvent event, Emitter<AccountState> emit) async {
    // get available cameras
    try {
      final cameras = await availableCameras();
      // get a camera controller
      final cameraController = CameraController(
        event.isFlipped ? cameras[1] : cameras[0],
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      // initialize camera
      await cameraController.initialize();
      await cameraController.lockCaptureOrientation();

      emit(
        state.copyWith(
          controller: cameraController,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> takePicture(
      TakePictureEvent event, Emitter<AccountState> emit) async {
    final XFile rawFile = await state.controller!.takePicture();
    final File image = File(rawFile.path);
    emit(
      state.copyWith(
        file: image,
      ),
    );
  }

  Future<void> sendPhotoToStorage(
      SendPhotoToStorageEvent event, Emitter<AccountState> emit) async {
    String imageName = 'profile_images/${state.user!.uid}';
    String? url;
    emit(
      state.copyWith(loading: true),
    );
    if (state.user!.photoUrl != null) {
      // if user has image then delete previous
      bool deleted = await firebaseStorageService.deleteUploadedFile(imageName);
      if (deleted) {
        url = await firebaseStorageService.uploadImage(
          state.file!,
          imageName,
        );
      }
    } else {
      url = await firebaseStorageService.uploadImage(
        state.file!,
        imageName,
      );
    }

    // update user info and add photo url into user data
    state.user!.photoUrl = url;
    await firestoreDatabaseService.updateUserInfo(state.user!);
    if (state.user!.photoUrl != null) {
      emit(
        state.copyWith(loading: false),
      );
      event.onSuccess?.call();
    }
  }

  Future<void> deletePhoto(
      DeletePhotoEvent event, Emitter<AccountState> emit) async {
    // get profile pic name
    String imageName = 'profile_images/${state.user!.uid}';

    bool deleted = false;
    // delete if user has a profile photo
    if (state.user!.photoUrl != null) {
      deleted = await firebaseStorageService.deleteUploadedFile(imageName);
    }
    if (deleted) {
      // update user info and delete photo url
      state.user!.photoUrl = null;
      await firestoreDatabaseService.updateUserInfo(state.user!);
    }
  }

  Future changeName(ChangeNameEvent event, Emitter<AccountState> emit) async {
    final bool isValid = state.form.validate();
    if (isValid) {
      emit(
        state.copyWith(loading: true),
      );
      // update user info
      state.user!.firstName = state.form.firstNameControl.value!;
      state.user!.lastName = state.form.lastNameControl.value!;

      await firestoreDatabaseService.updateUserInfo(state.user!);

      // if user changes only name
      if (state.file == null) {
        event.onSuccess?.call();
      } else {
        // if file successfuly chosen than awit upload photo and then pop page and clear state file

        add(
          SendPhotoToStorageEvent(
            onSuccess: () => event.onSuccess?.call(),
          ),
        );
      }
      emit(
        state.copyWith(loading: false),
      );
    }
  }

  clearStateFile(ClearStateFileEvent event, Emitter<AccountState> emit) {
    emit(
      state.copyWithFile(
        file: null,
      ),
    );
  }

  resetAccountPage(ResetAccountPageEvent event, Emitter<AccountState> emit) {
    emit(
      AccountState(
        form: ChangeNameForm(),
        loading: false,
      ),
    );
  }
}
