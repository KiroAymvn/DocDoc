import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_exceptions.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  Future<String> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String gender,
  }) async {
    try {
      final response = await _apiService.post("/auth/register", {
        "name": name,
        "email": email,
        "gender": gender,
        "phone": phone,
        "password": password,
        "password_confirmation": confirmPassword,
      });
      return response["data"]["token"];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<Map<String,dynamic>> logIn({required String email, required String password}) async {
    FormData formData = FormData.fromMap({"email": email, "password": password});
    try {
      final response = await _apiService.post("/auth/login", formData);
      return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
