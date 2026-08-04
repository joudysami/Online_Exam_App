import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Profile/domain/repo/profile_repository.dart';
import 'package:exam_app/feature/Profile/data/models/change_password_request.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<BaseResponse<String>> call(ChangePasswordRequest request) {
    return repository.changePassword(request);
  }
}
