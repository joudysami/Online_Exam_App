import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/data/models/check_answers_request.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckExamAnswersUseCase {
  final HomeRepo homeRepo;

  CheckExamAnswersUseCase(this.homeRepo);

  Future<BaseResponse<ScoreEntity>> call(CheckAnswersRequest request) async {
    return await homeRepo.checkAnswers(request);
  }
}
