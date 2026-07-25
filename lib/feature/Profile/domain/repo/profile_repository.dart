import 'package:exam_app/config/base/base_response.dart';
import '../entity/profile_entity.dart';
import '../../data/models/edit_profile_request.dart';
import '../../data/models/change_password_request.dart';

abstract class ProfileRepository {
  Future<BaseResponse<ProfileEntity>> editProfile(EditProfileRequest request);
  Future<BaseResponse<String>> changePassword(ChangePasswordRequest request);
}
