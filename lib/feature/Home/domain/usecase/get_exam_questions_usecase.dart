import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExamQuestionsUseCase {
  final HomeRepo homeRepo;

  GetExamQuestionsUseCase(this.homeRepo);

  Future<BaseResponse<List<QuestionEntity>>> call(String examId) async {
    return await homeRepo.getQuestionsByExam(examId);
  }
}
