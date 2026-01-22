part of 'dashboard_bloc.dart';

class DashboardState {
  final List<Organization> organizations;
  final Organization? selectedOrganization;
  final List<Project> projects;
  final Project? selectedProject;
  final bool isLoading;

  const DashboardState({
    this.organizations = const [],
    this.selectedOrganization,
    this.projects = const [],
    this.selectedProject,
    this.isLoading = false,
  });

  DashboardState copyWith({
    List<Organization>? organizations,
    Organization? selectedOrganization,
    List<Project>? projects,
    Project? selectedProject,
    bool? isLoading,
  }) {
    return DashboardState(
      organizations: organizations ?? this.organizations,
      selectedOrganization: selectedOrganization ?? this.selectedOrganization,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
