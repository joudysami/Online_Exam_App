
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/data/models/history_response.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';
import 'package:exam_app/feature/Home/data/models/questions_response.dart';
import 'package:exam_app/feature/Home/data/models/check_answers_request.dart';
import 'package:exam_app/feature/Home/data/models/check_answers_response.dart';

abstract interface class HomeRemoteDatasource {
  Future<SubjectsResponse> getAllSubjects();
  Future<ExamsResponse> getAllExams(String subjectId);
  Future<QuestionsResponse> getQuestionsByExam(String examId);
  Future<CheckAnswersResponse> checkAnswers(CheckAnswersRequest request);
  Future<HistoryResponse> getHistory();
}