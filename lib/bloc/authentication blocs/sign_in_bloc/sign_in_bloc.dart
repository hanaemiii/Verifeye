import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_state.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';
import 'package:verifeye/core/forms/sign_in_form.dart';
import 'package:verifeye/core/resources/data_state.dart';
import 'package:verifeye/core/utils/network.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
      : super(
          SignInState(
            signInForm: SignInForm(),
            loading: false,
          ),
        ) {
    on<UserSignInEvent>(userSignIn);
    on<UserSignOutEvent>(userSignOut);
    on<ResendVerificationEmailEvent>(resendVerificationEmail);
    on<ResetStateEvent>(resetState);
  }
  final AuthService authService = GetIt.I<AuthService>();

  userSignIn(UserSignInEvent event, Emitter<SignInState> emit) async {
    final isValid = state.signInForm.validate();

    bool isOnline = await NetworkUtils.isOnline();
    if (isOnline) {
      if (isValid) {
        emit(
          state.copyWith(loading: true),
        );
        final response = await authService.signInWithEmailAndPassword(
          email: state.signInForm.emailControl.value!,
          password: state.signInForm.passwordControl.value!,
        );

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

  resendVerificationEmail(
      ResendVerificationEmailEvent event, Emitter<SignInState> emit) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser!.emailVerified == false) {
      currentUser.sendEmailVerification();
    }
    event.onSuccess?.call();
  }

  Future<void> userSignOut(
      UserSignOutEvent event, Emitter<SignInState> emit) async {
    await authService.signOut();
    event.onSuccess?.call();
  }

  resetState(ResetStateEvent event, Emitter<SignInState> emit) {}
}
