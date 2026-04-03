import 'package:connectivity_plus/connectivity_plus.dart';

/// Checks internet connectivity using the connectivity_plus package.
/// Simple, stateless — call [hasInternet] anywhere you need to.
class ConnectivityService {
  ConnectivityService._(); // static-only class

  /// Returns true if the device has an active network connection.
  /// Note: This checks network reachability, not whether a server is online.
  static Future<bool> hasInternet() async {
    final results = await Connectivity().checkConnectivity();
    // results is a List<ConnectivityResult> in newer versions
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );
  }
}
