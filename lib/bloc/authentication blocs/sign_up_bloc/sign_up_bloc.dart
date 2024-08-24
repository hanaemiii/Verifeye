import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_state.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';
import 'package:verifeye/core/forms/sign_up_form.dart';
import 'package:verifeye/core/resources/data_state.dart';
import 'package:verifeye/core/utils/network.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()
      : super(
          SignUpState(
            form: SignUpForm(),
            loading: false,
            gradeData: const [],
          ),
        ) {
    on<CreateUserEvent>(createUser);
    on<ClearSignUpFieldsEvent>(clearSignUpFields);
  }

  final authService = GetIt.I<AuthService>();

  Future<void> createUser(
      CreateUserEvent event, Emitter<SignUpState> emit) async {
    final bool isValid = state.form.validate();
    bool isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      if (isValid) {
        emit(
          state.copyWith(loading: true),
        );
        final response = await authService.signUpWithEmailAndPassword(
          email: state.form.emailControl.value!,
          password: state.form.passwordControl.value!,
          firstName: state.form.firstNameControl.value!,
          lastName: state.form.lastNameControl.value!,
        );

        // response.data.user.
        if (response is DataSuccess) {
          event.onSuccess?.call();
        } else {
          event.onError?.call(response.exception!);
        }
        emit(
          state.copyWith(loading: false),
        );
      }
    } else {
      event.onInternetError?.call();
    }
  }

  clearSignUpFields(ClearSignUpFieldsEvent event, Emitter<SignUpState> emit) {
    state.form.clear();
  }
}
