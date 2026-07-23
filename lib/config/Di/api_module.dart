import 'package:dio/dio.dart';
import 'package:exam_app/feature/Home/data/api/home_api_client.dart';
import 'package:injectable/injectable.dart';
import '../../feature/Auth/data/api/auth_api_client.dart';

@module
abstract class ApiModule {
  @lazySingleton
  HomeApiClient provideHomeApiClient(Dio dio) {
    return HomeApiClient(dio);
  }
  @lazySingleton
  AuthApiClient provideAuthApiClient(Dio dio) => AuthApiClient(dio);
}
