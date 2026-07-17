import 'package:exam_app/feature/Auth/data/models/login_request.dart';
import 'package:exam_app/feature/Auth/data/models/auth_response.dart';
import 'package:exam_app/feature/Auth/data/models/forget_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/verify_reset_code_request.dart';
import 'package:exam_app/feature/Auth/data/models/reset_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> signIn(LoginRequest request);
  Future<AuthResponse> signUp(SignUpRequest request);
  Future<AuthResponse> forgotPassword(ForgetPasswordRequest request);
  Future<AuthResponse> verifyResetCode(VerifyResetCodeRequest request);
  Future<AuthResponse> resetPassword(ResetPasswordRequest request);
}