import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_environment.dart';
import 'env_keys.dart';

class EnvironmentConfig {
  static late final String apiBaseUrl;
  static late final String apiVersion;
  static late final AppEnvironment environment;
  static late final bool isLoggingEnabled;

  static void init(AppEnvironment env) {
    environment = env;
    apiBaseUrl = _getRequired(EnvKeys.apiBaseUrl);
    apiVersion = _getRequired(EnvKeys.apiVersion);
    isLoggingEnabled = _getOptionalBool(EnvKeys.enableLogging) ?? false;
  }

  static String _getRequired(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Missing required environment variable: $key');
    }
    return value;
  }

  static bool? _getOptionalBool(String key) {
    final value = dotenv.env[key];
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }
}
