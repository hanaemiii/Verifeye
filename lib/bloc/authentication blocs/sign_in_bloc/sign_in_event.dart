import 'package:verifeye/core/errors/base_exception.dart';

class SignInEvent {}

class UserSignInEvent extends SignInEvent {
  final void Function()? onSuccess;
  final void Function()? onInternetError;
  final void Function(BaseException)? onError;

  UserSignInEvent({
    required this.onError,
    required this.onSuccess,
    required this.onInternetError,
  });
}

class UserSignOutEvent extends SignInEvent {
  final void Function()? onSuccess;
  UserSignOutEvent({
    required this.onSuccess,
  });
}

class ResendVerificationEmailEvent extends SignInEvent {
  final void Function()? onSuccess;
  ResendVerificationEmailEvent({
    required this.onSuccess,
  });
}
