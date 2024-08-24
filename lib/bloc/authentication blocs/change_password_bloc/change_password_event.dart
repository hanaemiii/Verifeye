import 'package:verifeye/core/errors/base_exception.dart';

class ChangePasswordEvent {}

class SetChangePasswordEvent extends ChangePasswordEvent {
  final void Function()? onSuccess;
  final void Function(BaseException)? onError;
  SetChangePasswordEvent({
    this.onError,
    this.onSuccess,
  });
}

class ClearFieldsvent extends ChangePasswordEvent {}
