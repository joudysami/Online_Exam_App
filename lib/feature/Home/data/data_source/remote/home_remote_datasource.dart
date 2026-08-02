
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';

abstract interface class HomeRemoteDatasource {
  Future<SubjectsResponse> getAllSubjects();
  Future<ExamsResponse> getAllExams(String subjectId);
}