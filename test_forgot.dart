import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions(baseUrl: 'https://exam.elevateegy.com/'));
  try {
    final r = await dio.post('api/v1/auth/forgotPassword', data: {'email': 'test@test.com'});
    print('SUCCESS: ${r.data}');
  } catch (e) {
    if (e is DioException) {
      print('ERROR STATUS: ${e.response?.statusCode}');
      print('ERROR DATA: ${e.response?.data}');
    } else {
      print('OTHER: $e');
    }
  }
}
