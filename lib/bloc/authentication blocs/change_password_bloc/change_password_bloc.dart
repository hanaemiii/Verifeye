import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_state.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';
import 'package:verifeye/core/forms/change_password_form.dart';
import 'package:verifeye/core/resources/data_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc()
      : super(
          ChangePasswordState(
            form: ChangePasswordForm(),
            loading: false,
          ),
        ) {
    on<ClearFieldsvent>(clearFields);
    on<SetChangePasswordEvent>(changePassword);
  }

  AuthService authService = GetIt.I<AuthService>();

  Future changePassword(
      SetChangePasswordEvent event, Emitter<ChangePasswordState> emit) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? currentUser = firebaseAuth.currentUser;

    final isValid = state.form.validate();
    if (isValid) {
      emit(
        state.copyWith(loading: true),
      );
      // reauthenticate user
      final response = await authService.reauthenticate(
        password: state.form.currentPasswordControl.value!,
      );
      emit(
        state.copyWith(loading: false),
      );
      if (response is DataSuccess) {
        // change password
        currentUser!.updatePassword(state.form.confirmPasswordControl.value!);
        event.onSuccess?.call();
      } else {
        event.onError?.call(response.exception!);
      }
    }
  }

  clearFields(ClearFieldsvent event, Emitter<ChangePasswordState> emit) {
    state.form.clear();
  }
}
