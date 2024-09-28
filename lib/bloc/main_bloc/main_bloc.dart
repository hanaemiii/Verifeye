import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verifeye/bloc/main_bloc/main_event.dart';
import 'package:verifeye/bloc/main_bloc/main_state.dart';
import 'package:verifeye/core/firebase_services/firebase_storage.dart';
import 'package:verifeye/core/firebase_services/firestore_database.dart';
import 'package:verifeye/helpers/functions/generate_image_name.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc()
      : super(
          const MainState(
            loading: false,
          ),
        ) {
    on<ChoosePhotoEvent>(choosePhoto);
    on<GetUserEvent>(getUser);
    on<UserEvent>(user);
    on<DeleteSelectedPhotoEvent>(deleteSelectedPhoto);
    on<SendToStorageEvent>(sendToStorage);
    on<ResetHomePageEvent>(resetHomePage);
    on<GetImageInfoEvent>(getImageInfo);
    on<UploadedImageTimeEvent>(uploadedImageTime);
  }
  final FirebaseStorageService firebaseStorageService =
      GetIt.I<FirebaseStorageService>();
  GenerateImageName generateImageName = GenerateImageName();
  final FirestoreDatabaseService firestoreDatabaseService =
      GetIt.I<FirestoreDatabaseService>();

  Future<void> choosePhoto(
      ChoosePhotoEvent event, Emitter<MainState> emit) async {
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

  Future<void> sendToStorage(
      SendToStorageEvent event, Emitter<MainState> emit) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );
    String currentUserUid = state.user!.uid;
    final String generatedName = generateImageName.generateName();
    // make file name
    String imageName = 'images/$currentUserUid/$generatedName';
    await firebaseStorageService.uploadImage(
      state.file!,
      imageName,
    );
    add(
      GetImageInfoEvent(),
    );
  }

  getUser(GetUserEvent event, Emitter<MainState> emit) {
    firestoreDatabaseService.getCurrentUser().listen(
      (user) {
        add(
          UserEvent(user),
        );
      },
    );
  }

  user(UserEvent event, Emitter<MainState> emit) {
    emit(
      state.copyWith(
        user: event.user,
      ),
    );
  }

  resetHomePage(ResetHomePageEvent event, Emitter<MainState> emit) {
    emit(
      const MainState(
        loading: false,
      ),
    );
  }

  getImageInfo(GetImageInfoEvent event, Emitter<MainState> emit) {
    firestoreDatabaseService.getImageInfo(state.user!.uid).listen(
      (imageInfo) {
        add(
          UploadedImageTimeEvent(imageInfo: imageInfo),
        );
      },
    );
  }

  uploadedImageTime(UploadedImageTimeEvent event, Emitter<MainState> emit) {
    if (event.imageInfo != null) {
      emit(
        state.copyWith(
          imageInfo: event.imageInfo!.time,
          loading: false,
        ),
      );
    }
  }

  Future<void> deleteSelectedPhoto(
      DeleteSelectedPhotoEvent event, Emitter<MainState> emit) async {
    emit(
      state.copyWithFile(
        file: null,
        imageInfo: null,
      ),
    );
    await firestoreDatabaseService.deletePhotoInfo(state.user!.uid);
    await firebaseStorageService
        .deleteImageFolder('images/${state.user!.uid}/');
  }
}
