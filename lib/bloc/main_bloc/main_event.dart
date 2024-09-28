import 'package:verifeye/models/image_info_model.dart';
import 'package:verifeye/models/user_model.dart';

class MainEvent {}

class ChoosePhotoEvent extends MainEvent {}

class DeleteSelectedPhotoEvent extends MainEvent {}

class SendToStorageEvent extends MainEvent {}

class GetUserEvent extends MainEvent {}

class UserEvent extends MainEvent {
  final AppUser? user;
  UserEvent(this.user);
}

class ResetHomePageEvent extends MainEvent {}

class GetImageInfoEvent extends MainEvent {}

class UploadedImageTimeEvent extends MainEvent {
  final ImageInfo? imageInfo;
  UploadedImageTimeEvent({
    required this.imageInfo,
  });
}
