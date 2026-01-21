enum AppEnvironment { development, staging, production }

extension AppEnvironmentExtension on AppEnvironment {
  String get fileName {
    switch (this) {
      case AppEnvironment.development:
        return '.env.dev';
      case AppEnvironment.staging:
        return '.env.staging';
      case AppEnvironment.production:
        return '.env.prod';
    }
  }
}
