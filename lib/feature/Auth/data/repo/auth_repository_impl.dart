import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/login_request.dart';
import 'package:exam_app/feature/Auth/data/models/forget_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/verify_reset_code_request.dart';
import 'package:exam_app/feature/Auth/data/models/reset_password_request.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/domain/repo/auth_repository.dart';
import 'package:exam_app/feature/Auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:exam_app/feature/Auth/data/datasource/local/auth_local_datasource.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<BaseResponse<AuthEntity>> signIn(LoginRequest request) async {
    try {
      final response = await remoteDatasource.signIn(request);
      if (response.token != null) {
        await localDatasource.saveToken(response.token!);
      }
      final entity = AuthEntity(
        token: response.token,
        email: response.user?.email,
        username: response.user?.username,
      );
      return SuccessResponse<AuthEntity>(entity);
    } catch (e) {
      return ErrorResponse<AuthEntity>(error: e);
    }
  }

  @override
  Future<BaseResponse<AuthEntity>> signUp(SignUpRequest request) async {
    try {
      final response = await remoteDatasource.signUp(request);
      if (response.token != null) {
        await localDatasource.saveToken(response.token!);
      }
      final entity = AuthEntity(
        token: response.token,
        email: response.user?.email,
        username: response.user?.username,
      );
      return SuccessResponse<AuthEntity>(entity);
    } catch (e) {
      return ErrorResponse<AuthEntity>(error: e);
    }
  }

  @override
  Future<BaseResponse<String>> forgotPassword(ForgetPasswordRequest request) async {
    try {
      final response = await remoteDatasource.forgotPassword(request);
      return SuccessResponse<String>(response.message ?? 'Reset code sent successfully');
    } catch (e) {
      return ErrorResponse<String>(error: e);
    }
  }

  @override
  Future<BaseResponse<String>> verifyResetCode(VerifyResetCodeRequest request) async {
    try {
      final response = await remoteDatasource.verifyResetCode(request);
      return SuccessResponse<String>(response.message ?? 'Code verified successfully');
    } catch (e) {
      return ErrorResponse<String>(error: e);
    }
  }

  @override
  Future<BaseResponse<String>> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await remoteDatasource.resetPassword(request);
      return SuccessResponse<String>(response.message ?? 'Password reset successfully');
    } catch (e) {
      return ErrorResponse<String>(error: e);
    }
  }
}
