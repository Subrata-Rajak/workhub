import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Future<bool> get isConnected async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // In connectivity_plus > 6.0.0, checkConnectivity returns List<ConnectivityResult>
    // However, for desktop, it might behave differently or return a single result in standard usage.
    // The current version 7.0.0 returns List<ConnectivityResult>.

    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
