import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptors implements Interceptor{

  final SharedPreferences sharedPreferences;
  AuthInterceptors(this.sharedPreferences);
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String?token=sharedPreferences.getString("token");
      options.headers['Authorization'] = 'Bearer $token';  
          return handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);  }
}
//send token and request//