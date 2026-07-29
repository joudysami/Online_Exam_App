import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constant/api_endpoints.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';
import '../models/forget_password_request.dart';
import '../models/verify_reset_code_request.dart';
import '../models/reset_password_request.dart';
import '../models/sign_up_request.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl:ApiEndpoints.baseUrl )
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST(ApiEndpoints.sinIn)
  Future<AuthResponse> signIn(@Body() LoginRequest request);

  @POST(ApiEndpoints.sinUp)

  Future<AuthResponse> signUp(@Body() SignUpRequest request);

  @POST(ApiEndpoints.forgotPassword)
  Future<AuthResponse> forgotPassword(@Body() ForgetPasswordRequest request);

  @POST(ApiEndpoints.verifyResetCode)
  Future<AuthResponse> verifyResetCode(@Body() VerifyResetCodeRequest request);

  @PUT(ApiEndpoints.resetPassword)
  Future<AuthResponse> resetPassword(@Body() ResetPasswordRequest request);
}