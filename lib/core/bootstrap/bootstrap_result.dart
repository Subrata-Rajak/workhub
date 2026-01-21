import '../env/app_environment.dart';

class BootstrapResult {
  final bool isSuccess;
  final AppEnvironment? environment;
  final String? failureReason;
  // In a real app with DI, you might pass back the container or initialized services here.
  // For now, services are likely static/singletons or accessed via their own instances.

  BootstrapResult.success(this.environment)
    : isSuccess = true,
      failureReason = null;

  BootstrapResult.failure(this.failureReason)
    : isSuccess = false,
      environment = null;

  bool get canProceedToApp => isSuccess;
}
