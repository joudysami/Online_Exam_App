import 'package:exam_app/feature/Profile/data/models/edit_profile_request.dart';
import 'package:exam_app/feature/Profile/data/models/change_password_request.dart';

sealed class ProfileEvent {}

class ToggleEditModeEvent extends ProfileEvent {
  final bool isEditing;
  ToggleEditModeEvent(this.isEditing);
}

class GetProfileDataEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final EditProfileRequest request;
  UpdateProfileEvent(this.request);
}

class ChangePasswordEvent extends ProfileEvent {
  final ChangePasswordRequest request;
  ChangePasswordEvent(this.request);
}
