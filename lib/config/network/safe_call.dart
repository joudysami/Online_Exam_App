import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/errors/error_parser.dart';

class SafeCall {
  Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return SuccessResponse(response);
    } catch (e) {
     final appError = errorParser(e as Exception);

      return ErrorResponse(
        appError: appError,
      );
    }
  }
}
//try catch//
//return safeApiCall(() => api.login());

