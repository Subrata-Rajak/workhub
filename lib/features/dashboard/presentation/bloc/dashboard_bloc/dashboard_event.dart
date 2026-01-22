part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class LoadDashboardData extends DashboardEvent {}

class SelectOrganization extends DashboardEvent {
  final Organization organization;
  SelectOrganization(this.organization);
}

class SelectProject extends DashboardEvent {
  final Project project;
  SelectProject(this.project);
}
