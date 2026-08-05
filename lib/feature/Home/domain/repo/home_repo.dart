import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/domain/entity/exam_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/history_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';
import 'package:exam_app/feature/Home/data/models/check_answers_request.dart';
abstract interface class HomeRepo {
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects();
   Future<BaseResponse<List<ExamEntity>>> getAllExams(String subjectId);
   Future<BaseResponse<List<QuestionEntity>>> getQuestionsByExam(String examId);
   Future<BaseResponse<ScoreEntity>> checkAnswers(CheckAnswersRequest request);
   Future<BaseResponse<List<HistoryEntity>>> getHistory();
}