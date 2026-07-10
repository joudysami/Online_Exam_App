import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
sealed class BaseResponse<T> {
  const BaseResponse();
}
class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  SuccessResponse(this.data);
}

class ErrorResponse<T> extends BaseResponse<T> {
  final Object? error;
  final String errorMessage;
  ErrorResponse({this.error, String? errorMessage})
    : errorMessage = error != null
          ? _extractErrorMessage(error)
          : (errorMessage ?? 'Something went wrong, please try again.');

  static String _extractErrorMessage(Object error) {
    if (error is SocketException) {
      return 'No internet connection, please check your network.';
    }

    // Timeout
    if (error is TimeoutException) {
      return 'Connection timeout, please try again.';
    }

    // Invalid JSON
    if (error is FormatException) {
      return 'Invalid server response.';
    }
    //Dio
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timeout, please try again.';
        case DioExceptionType.connectionError:
          return 'No internet connection, please check your network.';
        case DioExceptionType.badCertificate:
          return 'Invalid certificate, please try again later.';
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.badResponse:
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            if (data['message'] != null) {
              return data['message'].toString();
            }

            if (data['error'] != null) {
              return data['error'].toString();
            }
          }
          return statusCodeToMessage(error.response?.statusCode);
        default:
          return 'Something went wrong, please check your connection.';
      }
    } else {
      return 'Something went wrong, please try again.';
    }
  }

  static String statusCodeToMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Something went wrong, please try again.';
      case 401:
        return 'Unauthorized, please login again.';
      case 403:
        return 'You are not allowed to perform this action.';
      case 404:
        return 'Resource not found.';
      case 409:
        return 'Conflict occurred.';
      case 429:
        return 'Too many requests, please try again later.';
      case 422:
        return 'No Data Found. ';
      case 500:
        return 'Internal server error, please try again later.';

      case 502:
        return 'Bad gateway.';

      case 503:
        return 'Service unavailable.';

      case 504:
        return 'Gateway timeout.';
      default:
        return 'Something went wrong, please try again.';
    }
  }
}
//Api Result//