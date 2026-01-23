import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'core/bootstrap/app_bootstrap.dart';
import 'core/env/app_environment.dart';
import 'core/routing/app_router.dart';
import 'core/routing/route_state.dart';
import 'src/src.dart';
import 'core/bootstrap/desktop_window_setup.dart';
import 'core/di/injection_container.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';

void main() async {
  // 1. Initialize Bindings
  WidgetsFlutterBinding.ensureInitialized();
  await setupDesktopWindow();

  // 2. Run App Bootstrap
  // TODO: In the future, this might select environment based on build flavor or flags.
  // For now, we default to development as per the initial setup instructions.
  final bootstrap = AppBootstrap();
  final result = await bootstrap.initialize(AppEnvironment.development);

  // 3. Initialize DI
  await setupDependencies();

  // Set bootstrap result into RouteState (which is now a singleton in DI)
  final routeState = sl<RouteState>();
  routeState.setBootstrapResult(result);

  // 4. Run App
  runApp(
    RepositoryProvider.value(
      value: sl<AppRouter>(),
      child: WorkHubApp(appRouter: sl<AppRouter>()),
    ),
  );
}

class WorkHubApp extends StatelessWidget {
  final AppRouter appRouter;

  const WorkHubApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadDashboardData()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          FlutterQuillLocalizations.delegate, // ✅ REQUIRED
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: const [
          Locale('en'), // add more later if needed
        ],
        title: 'WorkHub',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter.router,
      ),
    );
  }
}
