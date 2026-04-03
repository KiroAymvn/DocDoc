/// Constants for all Hive box names used throughout the app.
/// Using constants avoids typos when opening/reading boxes.
class HiveBoxes {
  // Private constructor — this class should never be instantiated
  HiveBoxes._();

  /// Stores the cached list of HomePageModel objects from the home API
  static const String homeData = 'home_data_box';

  /// Stores the cached list of all DoctorModel objects
  static const String allDoctors = 'all_doctors_box';

  /// Stores the user's favorite DoctorModel objects (keyed by doctorId)
  static const String favorites = 'favorites_box';

  /// Stores the logged-in user's UserModel for offline access
  static const String userProfile = 'user_profile_box';

  /// Stores the cached list of AppointmentModel objects
  static const String appointments = 'appointments_box';
}
