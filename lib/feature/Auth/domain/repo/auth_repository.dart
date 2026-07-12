import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/login_request.dart';
import 'package:exam_app/feature/Auth/data/models/forget_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/verify_reset_code_request.dart';
import 'package:exam_app/feature/Auth/data/models/reset_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';
import '../entity/auth_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<AuthEntity>> signIn(LoginRequest request);
  Future<BaseResponse<AuthEntity>> signUp(SignUpRequest request);
  Future<BaseResponse<String>> forgotPassword(ForgetPasswordRequest request);
  Future<BaseResponse<String>> verifyResetCode(VerifyResetCodeRequest request);
  Future<BaseResponse<String>> resetPassword(ResetPasswordRequest request);
}
