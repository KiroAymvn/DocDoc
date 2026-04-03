import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/storage/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesRepo {
  // 1. MUST add <DoctorModel> exactly here after Hive.box
  final Box<DoctorModel> box = Hive.box<DoctorModel>(HiveBoxes.favorites);

  List<DoctorModel> getFavorites() {
    try {
      // 2. Safely create a list of DoctorModel
      return List<DoctorModel>.from(box.values);
    } catch (e) {
      // 3. Fallback: If old corrupted dynamic data is found, clear the box to fix the crash
      print("Corrupted data found in Hive. Clearing box...");
      box.clear();
      return [];
    }
  }

  bool isFavorite(int doctorId) {
    return box.containsKey(doctorId);
  }

  Future<void> addFavorite(DoctorModel doctor) async {
    await box.put(doctor.doctorId, doctor);
  }

  Future<void> removeFavorite(int doctorId) async {
    await box.delete(doctorId);
  }

  Future<bool> toggleFavorite(DoctorModel doctor) async {
    if (isFavorite(doctor.doctorId)) {
      await removeFavorite(doctor.doctorId);
      return false;
    } else {
      await addFavorite(doctor);
      return true;
    }
  }
}