import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/features/appointment/data/model/appointment_model.dart';
import 'package:dio/dio.dart';

class AppointmentRepo {
  ApiService _apiService=ApiService();
  
  Future<AppointmentModel> postAppointment({required String doctorId,
    required String startDate, 
    String? notes}) async {
    try{
      final response= await _apiService.post("/appointment/store", {
        "doctor_id":doctorId,
        "start_time":startDate,
        "notes":notes??""
      });
      final AppointmentModel appointmentModel=AppointmentModel.fromJson(response["data"]);
      return  appointmentModel;
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }
  }

  Future<List<AppointmentModel>> getAppointment ()async{
    try{
      final response = await _apiService.get("/appointment/index");
      return (response["data"] as List).map((e)=>AppointmentModel.fromJson(e)).toList();
    } on DioException catch(e){
      throw ApiExceptions.handleError(e);

    }
  }

}
