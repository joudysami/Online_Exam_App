import 'package:exam_app/config/network/safe_call.dart';
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
  final SafeCall safeCall;
  AuthRepositoryImpl(
    this.remoteDatasource,
    this.localDatasource,
    this.safeCall,
  );

  @override
  Future<BaseResponse<AuthEntity>> signIn(LoginRequest request) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.signIn(request);
      if (response.token != null) {
        await localDatasource.saveToken(response.token!);
      }
      return AuthEntity(
        token: response.token,
        email: response.user?.email,
        username: response.user?.username,
      );
    });
  }

  @override
  Future<BaseResponse<AuthEntity>> signUp(SignUpRequest request) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.signUp(request);
      if (response.token != null) {
        await localDatasource.saveToken(response.token!);
      }
      return AuthEntity(
        token: response.token,
        email: response.user?.email,
        username: response.user?.username,
      );
    });
  }

  @override
  Future<BaseResponse<String>> forgotPassword(
    ForgetPasswordRequest request,
  ) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.forgotPassword(request);
      return response.message ?? 'Reset code sent successfully';
    });
  }

  @override
  Future<BaseResponse<String>> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.verifyResetCode(request);
      return response.message ?? 'Code verified successfully';
    });
  }

  @override
  Future<BaseResponse<String>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    return safeCall.safeApiCall(() async {
      final response = await remoteDatasource.resetPassword(request);
      return response.message ?? 'Password reset successfully';
    });
  }
}
