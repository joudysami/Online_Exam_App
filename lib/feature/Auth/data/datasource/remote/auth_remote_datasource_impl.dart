import 'package:injectable/injectable.dart';
import 'package:exam_app/feature/Auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:exam_app/feature/Auth/data/api/auth_api_client.dart';
import 'package:exam_app/feature/Auth/data/models/login_request.dart';
import 'package:exam_app/feature/Auth/data/models/auth_response.dart';
import 'package:exam_app/feature/Auth/data/models/forget_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/verify_reset_code_request.dart';
import 'package:exam_app/feature/Auth/data/models/reset_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';

@Injectable(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AuthApiClient authApiClient;

  AuthRemoteDatasourceImpl(this.authApiClient);

  @override
  Future<AuthResponse> signIn(LoginRequest request) {
    return authApiClient.signIn(request);
  }

  @override
  Future<AuthResponse> signUp(SignUpRequest request) {
    return authApiClient.signUp(request);
  }

  @override
  Future<AuthResponse> forgotPassword(ForgetPasswordRequest request) {
    return authApiClient.forgotPassword(request);
  }

  @override
  Future<AuthResponse> verifyResetCode(VerifyResetCodeRequest request) {
    return authApiClient.verifyResetCode(request);
  }

  @override
  Future<AuthResponse> resetPassword(ResetPasswordRequest request) {
    return authApiClient.resetPassword(request);
  }
}