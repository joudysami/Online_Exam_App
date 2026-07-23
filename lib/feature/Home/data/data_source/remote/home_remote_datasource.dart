
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';

abstract class HomeRemoteDatasource {
  Future<SubjectsResponse> geAllSubjects();
  Future<ExamsResponse> getExams(String subjectId);
}