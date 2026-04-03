import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/storage/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Handles all CRUD operations for favorite doctors stored in Hive.
class FavoritesRepo {
  // Get the already-opened Hive box
  Box get _box => Hive.box(HiveBoxes.favorites);

  /// Returns all saved favorite doctors.
  List<DoctorModel> getFavorites() {
    final values = _box.values;
    return values.cast<DoctorModel>().toList();
  }

  /// Returns true if a doctor with this [doctorId] is in favorites.
  bool isFavorite(int doctorId) {
    return _box.containsKey(doctorId);
  }

  /// Adds a doctor to favorites. Key = doctorId for fast lookup.
  Future<void> addFavorite(DoctorModel doctor) async {
    await _box.put(doctor.doctorId, doctor);
  }

  /// Removes a doctor from favorites by their ID.
  Future<void> removeFavorite(int doctorId) async {
    await _box.delete(doctorId);
  }

  /// Toggles favorite status — adds if not present, removes if present.
  /// Returns true if the doctor was added, false if removed.
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
