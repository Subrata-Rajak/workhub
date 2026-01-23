import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_org_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_shell.dart';
import '../../features/members/presentation/pages/members_page.dart';
import '../../features/projects/presentation/pages/projects_page.dart';
import '../../features/projects/presentation/pages/project_details_page.dart';
import '../../features/roles_and_permissions/presentation/pages/roles_and_permissions_page.dart';
import 'route_guards.dart';
import 'route_paths.dart';
import 'route_state.dart';

class AppRouter {
  final RouteState routeState;

  AppRouter(this.routeState);

  late final GoRouter router = GoRouter(
    refreshListenable: routeState,
    initialLocation:
        RoutePaths.dashboard, // Changed to dashboard to test immediate entry
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

      // Authenticated Shell
      ShellRoute(
        builder: (context, state, child) {
          return DashboardShell(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.dashboard,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardPage()),
          ),
          GoRoute(
            path: RoutePaths.projects,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProjectsPage()),
          ),
          GoRoute(
            path: RoutePaths.projectDetails,
            pageBuilder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              return NoTransitionPage(
                child: ProjectDetailsPage(projectId: projectId),
              );
            },
          ),
          GoRoute(
            path: RoutePaths.members,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MembersPage()),
          ),
          GoRoute(
            path: RoutePaths.roles,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: RolesAndPermissionsPage()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
