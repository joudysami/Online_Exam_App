import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/network/safe_call.dart';
import 'package:exam_app/feature/Home/data/data_source/remote/home_remote_datasource.dart';
import 'package:exam_app/feature/Home/domain/entity/exam_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/history_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';
import 'package:exam_app/feature/Home/data/models/check_answers_request.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource homeRemoteDatasource;
  final SafeCall safeCall;
  HomeRepoImpl(this.homeRemoteDatasource, this.safeCall);
  @override
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects() {
    return safeCall.safeApiCall(() async {
      final response = await homeRemoteDatasource.getAllSubjects();
      return response.subjects?.map((subject) => subject.toDomain()).toList() ??
          [];
    });
  }

  @override
  Future<BaseResponse<List<ExamEntity>>> getAllExams(String subjectId) {
    return safeCall.safeApiCall(() async {
      final response = await homeRemoteDatasource.getAllExams(subjectId);
      return response.exams?.map((exam) => exam.toDomain()).toList() ?? [];
    });
  }

  @override
  Future<BaseResponse<List<QuestionEntity>>> getQuestionsByExam(String examId) {
    return safeCall.safeApiCall(() async {
      final response = await homeRemoteDatasource.getQuestionsByExam(examId);
      return response.questions?.map((q) => q.toDomain()).toList() ?? [];
    });
  }

  @override
  Future<BaseResponse<ScoreEntity>> checkAnswers(CheckAnswersRequest request) {
    return safeCall.safeApiCall(() async {
      final response = await homeRemoteDatasource.checkAnswers(request);
      return response.toDomain();
    });
  }

  @override
  Future<BaseResponse<List<HistoryEntity>>> getHistory() {
    return safeCall.safeApiCall(() async {
      final response = await homeRemoteDatasource.getHistory();
      return response.history?.map((history) => history.toDomain()).toList() ?? [];
    });
  }
}
