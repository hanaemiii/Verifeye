import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
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
          const MainState(),
        ) {
    on<ChoosePhotoEvent>(choosePhoto);
    on<GetUserEvent>(getUser);
    on<UserEvent>(user);
    on<DeleteSelectedPhotoEvent>(
      (event, emit) => emit(
        state.copyWithFile(
          file: null,
        ),
      ),
    );
    on<SendToStorageEvent>(sendToStorage);
    on<ResetHomePageEvent>(resetHomePage);
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
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final String generatedName = generateImageName.generateName();
    // make file name
    String imageName = 'images/$currentUserUid/$generatedName';
    // ignore: unused_local_variable
    String imageUrl = await firebaseStorageService.uploadImage(
      state.file!,
      imageName,
    );
    // pass this url to user
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
      const MainState(),
    );
  }
}
