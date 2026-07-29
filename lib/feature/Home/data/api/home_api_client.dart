import 'package:dio/dio.dart';
import 'package:exam_app/core/constant/api_endpoints.dart';
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';
@RestApi(baseUrl: ApiEndpoints.baseUrl)

abstract class HomeApiClient {
factory HomeApiClient(Dio dio, {String baseUrl}) = _HomeApiClient;
@GET(ApiEndpoints.subject)
Future<SubjectsResponse> geAllSubjects( @Header("Authorization") String token,);

  @GET(ApiEndpoints.exam)
  Future<ExamsResponse> getAllExams(
    @Query("subject") String subjectId,
  );
}