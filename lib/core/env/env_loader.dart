import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_environment.dart';

class EnvLoader {
  static Future<void> load({required AppEnvironment env}) async {
    await dotenv.load(fileName: env.fileName);
  }
}
