import 'package:get_it/get_it.dart';
import 'app_dependencies.dart';
import 'feature_dependencies.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // 1. External Dependencies (Third-party libraries, etc - if any)

  // 2. Core/App Dependencies (Router, RouteState, etc)
  await registerAppDependencies();

  // 3. Feature Dependencies (BLoCs, etc)
  registerFeatureDependencies();
}
