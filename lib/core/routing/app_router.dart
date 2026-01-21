import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_org_page.dart';
import 'route_guards.dart';
import 'route_paths.dart';
import 'route_state.dart';

class AppRouter {
  final RouteState routeState;

  AppRouter(this.routeState);

  late final GoRouter router = GoRouter(
    refreshListenable: routeState,
    initialLocation: RoutePaths.initial,
    redirect: (context, state) => routeGuard(context, state, routeState),
    routes: [
      GoRoute(
        path: RoutePaths.initial,
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: RoutePaths.bootstrapError,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Bootstrap Failed. Please restart.')),
        ),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        builder: (context, state) => const SignupOrgPage(),
      ),
      GoRoute(
        path: RoutePaths.selectOrganization,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Select Organization Placeholder')),
        ),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Dashboard Placeholder'))),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
