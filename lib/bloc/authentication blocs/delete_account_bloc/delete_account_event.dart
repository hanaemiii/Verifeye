import 'package:verifeye/core/errors/base_exception.dart';

class DeleteAccountEvent {}

class CheckBoxEvent extends DeleteAccountEvent {}

class ConfirmDeletingEvent extends DeleteAccountEvent {
  final void Function()? onSuccess;
  final void Function(BaseException)? onError;

  ConfirmDeletingEvent({
    this.onSuccess,
    this.onError,
  });
}
