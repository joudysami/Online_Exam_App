import 'package:dio/dio.dart';
import 'package:exam_app/feature/Auth/data/models/auth_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constant/api_constants.dart';
import '../models/edit_profile_request.dart';
import '../models/change_password_request.dart';

part 'profile_api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @PUT(EndPoints.editProfile)
  Future<AuthResponse> editProfile(@Body() EditProfileRequest request);

  @PATCH(EndPoints.changePassword)
  Future<AuthResponse> changePassword(@Body() ChangePasswordRequest request);

  @GET(EndPoints.profileData)
  Future<AuthResponse> getProfileData();
}
