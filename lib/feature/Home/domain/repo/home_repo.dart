import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/domain/entity/exam_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';

abstract interface class HomeRepo {
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects();
   Future<BaseResponse<List<ExamEntity>>> getAllExams(String subjectId);

}