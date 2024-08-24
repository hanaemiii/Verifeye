import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/authentication%20blocs/forgot_password_bloc/forgot_password_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/forgot_password_bloc/forgot_password_state.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';
import 'package:verifeye/core/forms/forgot_password_form.dart';
import 'package:verifeye/core/resources/data_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc()
      : super(
          ForgotPasswordState(
            form: ForgotPasswordForm(),
            loading: false,
            response: const DataSuccess(0),
          ),
        ) {
    on<SendEmailEvent>(sendEmail);
    // on<ClearForgotPasswordFieldsEvent>(clearForgotPasswordFields);
  }

  final authService = GetIt.I<AuthService>();

  Future sendEmail(
      SendEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    final isValid = state.form.validate();

    if (isValid) {
      emit(
        state.copyWith(loading: true),
      );
      final response = await authService.sendPasswordResetEmail(
        email: state.form.emailControl.value!,
      );
      if (response is DataSuccess) {
        event.onSuccess?.call();
      }
      emit(
        state.copyWith(
          loading: false,
          response: response,
        ),
      );
    }
  }

  // clearForgotPasswordFields(
  //     ClearForgotPasswordFieldsEvent event, Emitter<ForgotPasswordState> emit) {
  //   state.form.clear();
  // }
}
