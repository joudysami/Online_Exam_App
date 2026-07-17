import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/reset_password_request.dart';
import 'package:exam_app/feature/Auth/domain/repo/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<BaseResponse<String>> call(String email, String newPassword) {
    return repository.resetPassword(
      ResetPasswordRequest(email: email, newPassword: newPassword),
    );
  }
}