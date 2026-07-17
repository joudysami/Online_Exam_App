import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/verify_reset_code_request.dart';
import 'package:exam_app/feature/Auth/domain/repo/auth_repository.dart';

@injectable
class VerifyCodeUseCase {
  final AuthRepository repository;

  VerifyCodeUseCase(this.repository);

  Future<BaseResponse<String>> call(String code) {
    return repository.verifyResetCode(VerifyResetCodeRequest(resetCode: code));
  }
}
