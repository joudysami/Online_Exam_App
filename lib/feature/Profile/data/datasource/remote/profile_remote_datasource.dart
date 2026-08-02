import 'package:exam_app/feature/Auth/data/models/auth_response.dart';
import '../../models/edit_profile_request.dart';
import '../../models/change_password_request.dart';

abstract interface class ProfileRemoteDataSource {
  Future<AuthResponse> editProfile(EditProfileRequest request);
  Future<AuthResponse> changePassword(ChangePasswordRequest request);
  Future<AuthResponse> getProfileData();
}
