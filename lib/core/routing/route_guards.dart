import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'route_paths.dart';
import 'route_state.dart';

String? routeGuard(
  BuildContext context,
  GoRouterState state,
  RouteState routeState,
) {
  final isBootstrapped = routeState.isBootstrapped;
  final isBootstrapSuccess = routeState.isBootstrapSuccess;
  final isAuthenticated = routeState.isAuthenticated;
  final hasSelectedOrganization = routeState.hasSelectedOrganization;

  final location = state.uri.toString();

  // 1. If not bootstrapped, stay on initial (loading) route
  if (!isBootstrapped) {
    return null; // Implicitly allow initial route
  }

  // 2. If bootstrap failed, redirect to error page
  if (!isBootstrapSuccess) {
    return location == RoutePaths.bootstrapError
        ? null
        : RoutePaths.bootstrapError;
  }

  // If we are on error page but bootstrap success (retry?), go to root
  if (isBootstrapSuccess && location == RoutePaths.bootstrapError) {
    return RoutePaths.initial;
  }

  // 3. Auth Guard
  final isLoggingIn =
      location == RoutePaths.login || location == RoutePaths.signup;

  if (!isAuthenticated) {
    return isLoggingIn ? null : RoutePaths.login;
  }

  // 4. Organization Guard
  if (isAuthenticated && !hasSelectedOrganization) {
    if (location == RoutePaths.selectOrganization) return null;
    return RoutePaths.selectOrganization;
  }

  // 5. If authenticated and has org, but trying to access login/signup/select-org -> dashboard
  if (isAuthenticated && hasSelectedOrganization) {
    if (isLoggingIn ||
        location == RoutePaths.selectOrganization ||
        location == RoutePaths.initial) {
      return RoutePaths.dashboard;
    }
  }

  return null;
}
