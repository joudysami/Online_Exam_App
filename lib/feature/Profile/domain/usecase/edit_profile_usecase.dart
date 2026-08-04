import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Profile/domain/entity/profile_entity.dart';
import 'package:exam_app/feature/Profile/domain/repo/profile_repository.dart';
import 'package:exam_app/feature/Profile/data/models/edit_profile_request.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);

  Future<BaseResponse<ProfileEntity>> call(EditProfileRequest request) {
    return repository.editProfile(request);
  }
}
