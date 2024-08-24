import 'package:verifeye/models/user_model.dart';

class AccountEvent {}

class GetUserInfoEvent extends AccountEvent {}

class UserDataEvent extends AccountEvent {
  final AppUser? user;
  UserDataEvent(this.user);
}

class ChooseProfilePhotoEvent extends AccountEvent {}

class OpenCameraEvent extends AccountEvent {
  final bool isFlipped;
  OpenCameraEvent(this.isFlipped);
}

class TakePictureEvent extends AccountEvent {}

class DeletePhotoEvent extends AccountEvent {}

class SendPhotoToStorageEvent extends AccountEvent {
  final Function()? onSuccess;
  SendPhotoToStorageEvent({
    required this.onSuccess,
  });
}

class ChangeNameEvent extends AccountEvent {
  final Function()? onSuccess;
  ChangeNameEvent({required this.onSuccess});
}

class ClearStateFileEvent extends AccountEvent {}
