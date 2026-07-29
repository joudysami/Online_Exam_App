import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';

abstract interface class HomeRepo {
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects();
   Future<BaseResponse<ExamsResponse>> getAllExams(String subjectId);

}