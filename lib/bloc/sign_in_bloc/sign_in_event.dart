import 'package:verifeye/core/errors/base_exception.dart';

class SignInEvent {}

class UserSignInEvent extends SignInEvent {
  final void Function()? onSuccess;
  // final void Function()? onSignInError;
  final void Function(BaseException)? onError;

  UserSignInEvent({
    required this.onError,
    required this.onSuccess,
    // required this.onSignInError,
  });
}

class UserSignOutEvent extends SignInEvent {
  final void Function()? onSuccess;
  UserSignOutEvent({
    required this.onSuccess,
  });
}
