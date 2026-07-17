import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../feature/Auth/data/api/auth_api_client.dart';

@module
abstract class ApiModule {
  @lazySingleton
  AuthApiClient provideAuthApiClient(Dio dio) => AuthApiClient(dio);
}
