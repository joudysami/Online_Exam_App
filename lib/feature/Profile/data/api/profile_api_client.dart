import 'dart:io';
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

  @MultiPart()
  @PUT("api/v1/auth/editProfile")
  Future<AuthResponse> editProfile({
    @Part(name: "username") required String username,
    @Part(name: "firstName") required String firstName,
    @Part(name: "lastName") required String lastName,
    @Part(name: "email") required String email,
    @Part(name: "phone") required String phone,
    @Part(name: "photo") File? photo,
  });

  @PATCH("api/v1/auth/changePassword")
  Future<AuthResponse> changePassword(@Body() ChangePasswordRequest request);
}
