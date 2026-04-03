import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/core/network/connectivity_service.dart';
import 'package:appointment/core/storage/hive_boxes.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileRepo {
  final ApiService _apiService = ApiService();

  Future<dynamic> getUserData() async {
    final bool online = await ConnectivityService.hasInternet();

    if (online) {
      try {
        final response = await _apiService.get("/user/profile");
        final userJson = response["data"][0];
        
        // Cache the UserModel
        final box = Hive.box(HiveBoxes.userProfile);
        await box.put('user', UserModel.fromJson(userJson));
        
        return userJson;
      } on DioException catch (e) {
        throw ApiExceptions.handleError(e);
      }
    } else {
      // Offline fallback
      final box = Hive.box(HiveBoxes.userProfile);
      final UserModel? cachedUser = box.get('user');
      
      if (cachedUser != null) {
        // Return a JSON-like map so the Cubit's UserModel.fromJson(data) still works
        return {
          "id": cachedUser.id,
          "name": cachedUser.name,
          "email": cachedUser.email,
          "phone": cachedUser.phone,
          "gender": cachedUser.gender,
        };
      }
      throw Exception('No internet connection and no cached profile data available.');
    }
  }

  Future<UserModel> updateUserData({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    try {
      final response = await _apiService.post("/user/update",{
        "name":name,
        "email":email,
        "phone":phone,
        "gender":gender,
        "password":password,
      });
      final updatedUser = UserModel.fromJson(response["data"]);
      
      // Update the cache
      final box = Hive.box(HiveBoxes.userProfile);
      await box.put('user', updatedUser);
      
      return updatedUser;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> logout() async {
    try {
      final response = await _apiService.post("/auth/logout", null);
      return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
