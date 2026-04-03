import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/core/network/connectivity_service.dart';
import 'package:appointment/core/storage/hive_boxes.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchRepo {
  final ApiService _apiService = ApiService();

  Future<List<DoctorModel>> searchDoctor({required String doctorName}) async {
    final bool online = await ConnectivityService.hasInternet();

    if (online) {
      try {
        final response = await _apiService.get("/doctor/doctor-search?name=$doctorName");
        return (response["data"] as List).map((e) => DoctorModel.fromMap(e)).toList();
      } on DioException catch (e) {
        throw ApiExceptions.handleError(e);
      }
    } else {
      // Offline fallback: Search through locally cached doctors
      final box = Hive.box(HiveBoxes.allDoctors);
      final cachedDoctors = box.get('list');

      if (cachedDoctors != null && cachedDoctors is List && cachedDoctors.isNotEmpty) {
        final allDoctors = cachedDoctors.cast<DoctorModel>();
        // Filter locally by name (case-insensitive)
        final query = doctorName.toLowerCase();
        return allDoctors.where((doctor) {
          return doctor.name.toLowerCase().contains(query);
        }).toList();
      }

      throw Exception('No internet connection. Please connect to search.');
    }
  }
}