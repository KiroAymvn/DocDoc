import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  ApiService _apiService = ApiService();

  Future<dynamic> getUserData() async {
    try {
      final response = await _apiService.get("/user/profile");
      return response["data"][0];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
  Future<UserModel>updateUserData({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async{
    try {
      final response = await _apiService.post("/user/update",{
        "name":name,
        "email":email,
        "phone":phone,
        "gender":gender,
        "password":password,
      });
      return UserModel.fromJson(response["data"]);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> logout() async {
    try {
      final response=await _apiService.post("/auth/logout", null);
return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
