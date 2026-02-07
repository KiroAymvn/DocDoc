import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiExceptions {
  //function to be called at any place in try and catch to make model from error
  static ApiError handleError(DioException error) {
    //if the error is exception
    switch (error.type) {
      case DioExceptionType.connectionError:
        throw ApiError.fromJson(error.response!.data);
      case DioExceptionType.connectionTimeout:
        throw ApiError.fromJson(error.response!.data);
      case DioExceptionType.sendTimeout:
        throw ApiError.fromJson(error.response!.data);

      case DioExceptionType.receiveTimeout:
        throw ApiError.fromJson(error.response!.data);

      case DioExceptionType.badCertificate:
        throw ApiError.fromJson(error.response!.data);

      case DioExceptionType.cancel:
        throw ApiError.fromJson(error.response!.data);

      case DioExceptionType.connectionError:
        throw ApiError.fromJson(error.response!.data);
    //error from user
      case DioExceptionType.badResponse:
        throw ApiError.fromJson(error.response!.data);
      case DioExceptionType.unknown:
      default:
        throw ApiError.fromJson(error.response!.data);
    }
  }
}
