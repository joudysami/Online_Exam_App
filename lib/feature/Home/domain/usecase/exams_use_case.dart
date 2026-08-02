import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/domain/entity/exam_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExamsUseCase {
  final HomeRepo homeRepo;
  GetExamsUseCase(this.homeRepo);

  Future<BaseResponse<List<ExamEntity>>> call(String subjectId) {
    return homeRepo.getAllExams(subjectId);
  }
}
