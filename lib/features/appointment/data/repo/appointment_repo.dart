import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/core/network/connectivity_service.dart';
import 'package:appointment/core/storage/hive_boxes.dart';
import 'package:appointment/features/appointment/data/model/appointment_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppointmentRepo {
  final ApiService _apiService = ApiService();
  
  Future<AppointmentModel> postAppointment({
    required String doctorId,
    required String startDate, 
    String? notes
  }) async {
    try {
      final response = await _apiService.post("/appointment/store", {
        "doctor_id": doctorId,
        "start_time": startDate,
        "notes": notes ?? "no notes"
      });
      final AppointmentModel appointmentModel = AppointmentModel.fromJson(response["data"]);
      
      // Add the new appointment to the local cache
      final box = Hive.box(HiveBoxes.appointments);
      final List<AppointmentModel> currentCache = box.get('list')?.cast<AppointmentModel>() ?? [];
      currentCache.add(appointmentModel);
      await box.put('list', currentCache);
      
      return appointmentModel;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<List<AppointmentModel>> getAppointment() async {
    final bool online = await ConnectivityService.hasInternet();

    if (online) {
      try {
        final response = await _apiService.get("/appointment/index");
        final List<AppointmentModel> appointments = (response["data"] as List)
            .map((e) => AppointmentModel.fromJson(e))
            .toList();

        // Save fresh data to Hive for later offline use
        final box = Hive.box(HiveBoxes.appointments);
        await box.put('list', appointments);

        return appointments;
      } on DioException catch (e) {
        throw ApiExceptions.handleError(e);
      }
    } else {
      // Offline fallback
      final box = Hive.box(HiveBoxes.appointments);
      final cached = box.get('list');

      if (cached != null && cached is List && cached.isNotEmpty) {
        return cached.cast<AppointmentModel>();
      }

      throw Exception('No internet connection and no cached appointments available.');
    }
  }
}
