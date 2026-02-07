import 'dart:developer';

import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  ApiService _apiService = ApiService();

  Future<List<HomePageModel>> getDoctorsHomeScreen() async {
    print("enter repo phase");
    try {
      print("enter repo phase try");

      final response = await _apiService.get("/home/index");
      return (response["data"] as List).map((e) => HomePageModel.fromJson(e)).toList();
    } on DioException catch (e) {
      print("enter repo phase catch");

      throw ApiExceptions.handleError(e);
    }
  }
  
  
  Future<List<DoctorModel>> getAllDoctors()async{
    try{
      final response =await _apiService.get("/doctor/index");
      return (response["data"] as List).map((e)=>DoctorModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }
  }
}
