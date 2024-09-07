class LogOutEvent {}

class UserLogOutEvent extends LogOutEvent {
  final void Function()? onSuccess;
  UserLogOutEvent({
    required this.onSuccess,
  });
}
