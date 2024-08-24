import 'package:verifeye/core/errors/base_exception.dart';

class SignUpEvent {}

class CreateUserEvent extends SignUpEvent {
  final void Function()? onSuccess;
  final void Function(BaseException)? onError;
  final void Function()? onInternetError;

  CreateUserEvent({
    this.onSuccess,
    this.onError,
    this.onInternetError,
  });
}

class ClearSignUpFieldsEvent extends SignUpEvent {}
