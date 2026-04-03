import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/network/api_exceptions.dart';
import 'package:appointment/core/network/api_service.dart';
import 'package:appointment/core/network/connectivity_service.dart';
import 'package:appointment/core/storage/hive_boxes.dart';
import 'package:appointment/core/utils/pref_helper.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeRepo {
  final ApiService _apiService = ApiService();

  // ─────────────────────────────────────────────────────────────
  // Home Screen Data  (speciality groups + their doctors)
  // ─────────────────────────────────────────────────────────────

  Future<List<HomePageModel>> getDoctorsHomeScreen() async {
    final bool online = await ConnectivityService.hasInternet();

    if (online) {
      // Online → fetch from API and cache the result
      return await _fetchAndCacheHomeData();
    } else {
      // Offline → only serve cached data if the user is logged in
      return await _getHomeDataFromCache();
    }
  }

  Future<List<HomePageModel>> _fetchAndCacheHomeData() async {
    try {
      final response = await _apiService.get("/home/index");
      final List<HomePageModel> homeData = (response["data"] as List)
          .map((e) => HomePageModel.fromJson(e))
          .toList();

      // Save fresh data to Hive for later offline use
      final box = Hive.box(HiveBoxes.homeData);
      await box.put('list', homeData);

      return homeData;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<List<HomePageModel>> _getHomeDataFromCache() async {
    final isLoggedIn = await PrefHelper.isLogged() ?? false;

    if (!isLoggedIn) {
      // Not logged in + no internet → hard error
      throw Exception('No internet connection. Please connect and try again.');
    }

    // Logged in → try to serve Hive cache
    final box = Hive.box(HiveBoxes.homeData);
    final cached = box.get('list');

    if (cached != null && cached is List && cached.isNotEmpty) {
      return cached.cast<HomePageModel>();
    }

    // Logged in but no cache yet
    throw Exception('No internet connection and no cached data available.');
  }

  // ─────────────────────────────────────────────────────────────
  // All Doctors List
  // ─────────────────────────────────────────────────────────────

  Future<List<DoctorModel>> getAllDoctors() async {
    final bool online = await ConnectivityService.hasInternet();

    if (online) {
      return await _fetchAndCacheAllDoctors();
    } else {
      return await _getAllDoctorsFromCache();
    }
  }

  Future<List<DoctorModel>> _fetchAndCacheAllDoctors() async {
    try {
      final response = await _apiService.get("/doctor/index");
      final List<DoctorModel> doctors = (response["data"] as List)
          .map((e) => DoctorModel.fromMap(e))
          .toList();

      // Cache for offline use
      final box = Hive.box(HiveBoxes.allDoctors);
      await box.put('list', doctors);

      return doctors;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<List<DoctorModel>> _getAllDoctorsFromCache() async {
    final isLoggedIn = await PrefHelper.isLogged() ?? false;

    if (!isLoggedIn) {
      throw Exception('No internet connection. Please connect and try again.');
    }

    final box = Hive.box(HiveBoxes.allDoctors);
    final cached = box.get('list');

    if (cached != null && cached is List && cached.isNotEmpty) {
      return cached.cast<DoctorModel>();
    }

    throw Exception('No internet connection and no cached data available.');
  }

  // ─────────────────────────────────────────────────────────────
  // Doctor by Speciality (search/filter — always requires internet)
  // ─────────────────────────────────────────────────────────────

  Future<HomePageModel> getDoctorSpeciality({required String specId}) async {
    try {
      final response = await _apiService.get("/specialization/show/$specId");
      return HomePageModel.fromJson(response["data"]);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
