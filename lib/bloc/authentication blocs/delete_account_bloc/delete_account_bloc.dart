import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/authentication%20blocs/delete_account_bloc/delete_account_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/delete_account_bloc/delete_account_state.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';
import 'package:verifeye/core/firebase_services/firebase_storage.dart';
import 'package:verifeye/core/firebase_services/firestore_database.dart';
import 'package:verifeye/core/forms/confirm_password_form.dart';
import 'package:verifeye/core/resources/data_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc()
      : super(
          DeleteAccountState(
            checked: false,
            loading: false,
            form: ConfirmPasswordForm(),
          ),
        ) {
    on<CheckBoxEvent>(checkBox);
    on<ConfirmDeletingEvent>(confirmDeleting);
  }

  AuthService authService = GetIt.I<AuthService>();
  final FirestoreDatabaseService firestoreDatabaseService =
      GetIt.I<FirestoreDatabaseService>();
  final FirebaseStorageService firebaseStorageService =
      GetIt.I<FirebaseStorageService>();

  checkBox(CheckBoxEvent event, Emitter<DeleteAccountState> emit) {
    emit(
      state.copyWith(checked: !state.checked),
    );
  }

  Future confirmDeleting(
      ConfirmDeletingEvent event, Emitter<DeleteAccountState> emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    // reauthenticate user
    final isValid = state.form.validate();

    if (isValid) {
      emit(
        state.copyWith(loading: true),
      );
      final response = await authService.reauthenticate(
        password: state.form.currentPasswordControl.value!,
      );

      if (response is DataSuccess) {
        // delete user profile pic
        String profilePicName = 'profile_images/${user!.uid}';
        await firebaseStorageService.deleteUploadedFile(profilePicName);
        // delete user uploaded photos
        String imageName = 'images/${user.uid}/';
        await firebaseStorageService.deleteImageFolder(imageName);
        // delete from auth
        user.delete();
        // delete from storage
        firestoreDatabaseService.deleteUser(user.uid);
        event.onSuccess?.call();
      } else {
        event.onError?.call(response.exception!);
      }
      emit(
        state.copyWith(loading: false),
      );
    }
  }
}
