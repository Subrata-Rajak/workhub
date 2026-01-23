import '../routing/app_router.dart';
import '../routing/route_state.dart';
import '../di/injection_container.dart';

Future<void> registerAppDependencies() async {
  // Route State
  sl.registerLazySingleton<RouteState>(() => RouteState());

  // App Router
  // We register AppRouter as a lazy singleton relying on the injected RouteState
  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<RouteState>()));
}
