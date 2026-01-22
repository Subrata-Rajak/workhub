import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bootstrap/app_bootstrap.dart';
import 'core/env/app_environment.dart';
import 'core/routing/app_router.dart';
import 'core/routing/route_state.dart';
import 'src/src.dart';
import 'core/bootstrap/desktop_window_setup.dart';

void main() async {
  // 1. Initialize Bindings
  WidgetsFlutterBinding.ensureInitialized();
  await setupDesktopWindow();

  // 2. Run App Bootstrap
  // TODO: In the future, this might select environment based on build flavor or flags.
  // For now, we default to development as per the initial setup instructions.
  final bootstrap = AppBootstrap();
  final result = await bootstrap.initialize(AppEnvironment.development);

  // 3. Initialize Route State & Router
  final routeState = RouteState();
  routeState.setBootstrapResult(result);

  final appRouter = AppRouter(routeState);

  // 4. Run App
  // 4. Run App
  runApp(
    RepositoryProvider.value(
      value: appRouter,
      child: WorkHubApp(appRouter: appRouter),
    ),
  );
}

class WorkHubApp extends StatelessWidget {
  final AppRouter appRouter;

  const WorkHubApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'WorkHub',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter.router,
    );
  }
}
