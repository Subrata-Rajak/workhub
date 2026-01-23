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
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/tasks/presentation/pages/task_details_page.dart';
import '../../features/settings/presentation/pages/organization_settings_page.dart';
import '../../features/audit_logs/presentation/pages/audit_logs_page.dart';
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
          GoRoute(
            path: RoutePaths.tasks,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TasksPage()),
          ),
          GoRoute(
            path: RoutePaths.taskDetails,
            pageBuilder: (context, state) {
              final taskId = state.pathParameters['taskId']!;
              return NoTransitionPage(child: TaskDetailsPage(taskId: taskId));
            },
          ),
          GoRoute(
            path: RoutePaths.settings,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: OrganizationSettingsPage()),
          ),
          GoRoute(
            path: RoutePaths.auditLogs,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AuditLogsPage()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
