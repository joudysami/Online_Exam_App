import 'package:dio/dio.dart';
import 'package:exam_app/core/constant/api_constants.dart';
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';
@RestApi(baseUrl: baseUrl)

abstract class HomeApiClient {
factory HomeApiClient(Dio dio, {String baseUrl}) = _HomeApiClient;
@GET("api/v1/subjects")
Future<SubjectsResponse> geAllSubjects( @Header("Authorization") String token,);

  @GET("api/v1/exams")
  Future<ExamsResponse> getExams(
    @Query("subject") String subjectId,
  );
}