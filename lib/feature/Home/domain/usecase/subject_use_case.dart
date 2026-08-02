import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubjectsUseCase {
  final HomeRepo homeRepo;
  GetSubjectsUseCase(this.homeRepo);
  
  Future<BaseResponse<List<SubjectEntity>>> call() {
    return homeRepo.getAllSubjects();
  }
}