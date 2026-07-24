import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/network/safe_call.dart';
import 'package:exam_app/feature/Home/data/data_source/remote/home_remote_datasource.dart';
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource homeRemoteDatasource;
    final SafeCall safeCall;
  HomeRepoImpl(this.homeRemoteDatasource, this.safeCall);
  @override
  //success with subject non_empty with 5 sub
  // success with subject empty 
  //error
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects() {
    return safeCall.safeApiCall(() async {
      final response = await homeRemoteDatasource.geAllSubjects();
      return response.subjects
            ?.map((subjects) => subjects.toDomain())
            .toList() ??
        [];
    });
  }

  @override
  Future<BaseResponse<ExamsResponse>> getExams(String subjectId) {
    // TODO: implement getExams
    throw UnimplementedError();
  }
} 