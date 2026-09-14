import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timed out while sending data. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your connection.';
      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response?.statusCode);
      case DioExceptionType.badResponse:
        return 'Request timed out while sending data. Please try again.';
      case DioExceptionType.cancel:
        return 'The request was cancelled.';
      case DioExceptionType.unknown:
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 404:
        return 'The requested data was not found.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'An error occurred (code $statusCode).';
    }
  }
}
