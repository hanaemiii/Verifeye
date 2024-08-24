class ForgotPasswordEvent {}

class SendEmailEvent extends ForgotPasswordEvent {
  final void Function()? onSuccess;

  SendEmailEvent({required this.onSuccess});
}

class ClearForgotPasswordFieldsEvent extends ForgotPasswordEvent {}
