import 'package:exam_app/config/base/base_response.dart';
class SafeCall {
  Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(error: e);
    }
  }
}
//try catch//
//return safeApiCall(() => api.login());