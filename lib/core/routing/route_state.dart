import 'package:flutter/foundation.dart';
import '../bootstrap/bootstrap_result.dart';
import '../env/app_environment.dart';

class RouteState extends ChangeNotifier {
  bool _isBootstrapped = false;
  bool _isBootstrapSuccess = false;
  AppEnvironment? _environment;

  // Placeholder auth states - will be replaced by real auth logic later
  bool _isAuthenticated = false;
  bool _hasSelectedOrganization = false;

  bool get isBootstrapped => _isBootstrapped;
  bool get isBootstrapSuccess => _isBootstrapSuccess;
  AppEnvironment? get environment => _environment;
  bool get isAuthenticated => _isAuthenticated;
  bool get hasSelectedOrganization => _hasSelectedOrganization;

  void setBootstrapResult(BootstrapResult result) {
    _isBootstrapped = true;
    _isBootstrapSuccess = result.isSuccess;
    _environment = result.environment;
    notifyListeners();
  }

  // Methods to update mock auth state for testing navigation flows
  void updateRoutingSession({
    bool? isAuthenticated,
    bool? hasSelectedOrganization,
  }) {
    if (isAuthenticated != null) {
      _isAuthenticated = isAuthenticated;
    }
    if (hasSelectedOrganization != null) {
      _hasSelectedOrganization = hasSelectedOrganization;
    }
    notifyListeners();
  }
}
