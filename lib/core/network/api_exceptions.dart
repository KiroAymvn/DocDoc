import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiExceptions {
  /// Safely convert a [DioException] to an [ApiError].
  /// Handles cases where the server returns non-JSON bodies (e.g. HTML 500 pages).
  static ApiError handleError(DioException error) {
    final response = error.response;

    // No response at all (network error, timeout, etc.)
    if (response == null) {
      throw ApiError(
        statusCode: 0,
        message: error.message ?? 'Network error. Please check your connection.',
      );
    }

    // Try to parse the body as JSON. If the server returned HTML or plain text
    // (e.g. a 500 error page), fromJson would crash — so we guard here.
    if (response.data is Map<String, dynamic>) {
      throw ApiError.fromJson(response.data as Map<String, dynamic>);
    }

    // Fallback: non-JSON body (HTML, plain text, etc.)
    throw ApiError(
      statusCode: response.statusCode,
      message: 'Server error (${response.statusCode}). Please try again later.',
    );
  }
}
