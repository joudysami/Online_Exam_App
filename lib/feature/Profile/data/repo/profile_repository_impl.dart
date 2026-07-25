import 'package:injectable/injectable.dart';
import 'package:exam_app/config/network/safe_call.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Profile/domain/entity/profile_entity.dart';
import 'package:exam_app/feature/Profile/domain/repo/profile_repository.dart';
import 'package:exam_app/feature/Profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:exam_app/feature/Profile/data/models/edit_profile_request.dart';
import 'package:exam_app/feature/Profile/data/models/change_password_request.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDatasource;
  final SafeCall safeCall;

  ProfileRepositoryImpl(this.remoteDatasource, this.safeCall);

  @override
  Future<BaseResponse<ProfileEntity>> editProfile(EditProfileRequest request) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.editProfile(request);
      return ProfileEntity(
        username: response.user?.username ?? '',
        firstName: response.user?.firstName ?? '',
        lastName: response.user?.lastName ?? '',
        email: response.user?.email ?? '',
        phone: response.user?.phone ?? '',
      );
    });
  }

  @override
  Future<BaseResponse<String>> changePassword(ChangePasswordRequest request) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.changePassword(request);
      return response.message ?? 'Password changed successfully';
    });
  }
}
