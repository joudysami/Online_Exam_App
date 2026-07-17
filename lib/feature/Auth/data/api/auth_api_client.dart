import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constant/api_constants.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';
import '../models/forget_password_request.dart';
import '../models/verify_reset_code_request.dart';
import '../models/reset_password_request.dart';
import '../models/sign_up_request.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST("api/v1/auth/signin")
  Future<AuthResponse> signIn(@Body() LoginRequest request);

  @POST("api/v1/auth/signup")
  Future<AuthResponse> signUp(@Body() SignUpRequest request);

  @POST("api/v1/auth/forgotPassword")
  Future<AuthResponse> forgotPassword(@Body() ForgetPasswordRequest request);

  @POST("api/v1/auth/verifyResetCode")
  Future<AuthResponse> verifyResetCode(@Body() VerifyResetCodeRequest request);

  @PUT("api/v1/auth/resetPassword")
  Future<AuthResponse> resetPassword(@Body() ResetPasswordRequest request);
}