import 'package:injectable/injectable.dart';
import '../../../../config/base/base_response.dart';
import '../../data/models/login_request.dart';
import '../entity/auth_entity.dart';
import '../repo/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<BaseResponse<AuthEntity>> call(LoginRequest request) {
    return repository.signIn(request);
  }
}