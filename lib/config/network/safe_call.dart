import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/errors/error_parser.dart';
import 'package:exam_app/config/errors/app_error.dart';
import 'package:injectable/injectable.dart';
@injectable
class SafeCall {
  Future<BaseResponse<T>> safeApiCall<T>(
    Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return SuccessResponse(response);
    } catch (e) {
      if (e is Exception) {
        final appError = errorParser(e);
        return ErrorResponse(appError: appError);
      }
      return ErrorResponse(
        appError: BadResponseError('Unexpected error: ${e.toString()}'),
      );
    }
  }
}
