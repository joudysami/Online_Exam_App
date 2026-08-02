import 'package:injectable/injectable.dart';
import 'package:exam_app/feature/Auth/data/models/auth_response.dart';
import 'profile_remote_datasource.dart';
import '../../api/profile_api_client.dart';
import '../../models/edit_profile_request.dart';
import '../../models/change_password_request.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient profileApiClient;

  ProfileRemoteDataSourceImpl(this.profileApiClient);

  @override
  Future<AuthResponse> editProfile(EditProfileRequest request) {
    return profileApiClient.editProfile(request);
  }

  @override
  Future<AuthResponse> changePassword(ChangePasswordRequest request) {
    return profileApiClient.changePassword(request);
  }

  @override
  Future<AuthResponse> getProfileData() {
    return profileApiClient.getProfileData();
  }
}
