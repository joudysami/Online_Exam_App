import 'package:exam_app/feature/Home/data/api/home_api_client.dart';
import 'package:exam_app/feature/Home/data/data_source/remote/home_remote_datasource.dart';
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
   final HomeApiClient homeApiClient;
   HomeRemoteDatasourceImpl(this.homeApiClient);
  @override
  Future<ExamsResponse> getExams(String subjectId) async {
    return await homeApiClient.getExams(subjectId);
  }

  @override
  Future<SubjectsResponse> geAllSubjects() async {
      final String tokenKey = 'USER_TOKEN';
    return await homeApiClient.geAllSubjects("Bearer $tokenKey");
  }
}