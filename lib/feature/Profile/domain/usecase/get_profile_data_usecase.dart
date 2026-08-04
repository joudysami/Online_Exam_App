import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Profile/domain/entity/profile_entity.dart';
import 'package:exam_app/feature/Profile/domain/repo/profile_repository.dart';

@injectable
class GetProfileDataUseCase {
  final ProfileRepository repository;

  GetProfileDataUseCase(this.repository);

  Future<BaseResponse<ProfileEntity>> call() async {
    return repository.getProfileData();
  }
}
