import 'package:hive_flutter/hive_flutter.dart';
import 'package:appointment/core/storage/hive_adapters.dart';
import 'package:appointment/core/storage/hive_boxes.dart';

/// Initializes Hive and opens all required boxes.
/// Must be called before [runApp] in main.dart.
class HiveService {
  HiveService._(); // private constructor — static use only

  /// Call this once at app startup.
  static Future<void> init() async {
    // Initialize Hive with the Flutter path provider
    await Hive.initFlutter();

    // Register adapters (order doesn't matter, but typeIds must match)
    _registerAdapters();

    // Open all boxes used by the app
    await Future.wait([
      Hive.openBox(HiveBoxes.homeData),
      Hive.openBox(HiveBoxes.allDoctors),
      Hive.openBox(HiveBoxes.favorites),
      Hive.openBox(HiveBoxes.userProfile),
      Hive.openBox(HiveBoxes.appointments),
    ]);
  }

  static void _registerAdapters() {
    // Guard against double-registration (e.g. during hot restart)
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SpecialityModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DoctorModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(HomePageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(AppointmentModelAdapter());
    }
  }

  /// Clears all cached data across all boxes. Useful on logout.
  static Future<void> clearAllBoxes() async {
    await Future.wait([
      Hive.box(HiveBoxes.homeData).clear(),
      Hive.box(HiveBoxes.allDoctors).clear(),
      Hive.box(HiveBoxes.favorites).clear(),
      Hive.box(HiveBoxes.userProfile).clear(),
      Hive.box(HiveBoxes.appointments).clear(),
    ]);
  }
}
