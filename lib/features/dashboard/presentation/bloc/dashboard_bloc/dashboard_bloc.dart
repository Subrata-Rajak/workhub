import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/organization.dart';
import '../../../data/models/project.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<SelectOrganization>(_onSelectOrganization);
    on<SelectProject>(_onSelectProject);
  }

  void _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Simulate Network Delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock Organizations
    final organizations = [
      const Organization(id: '1', name: 'Acme Corp', role: 'Admin'),
      const Organization(id: '2', name: 'Stark Industries', role: 'Member'),
      const Organization(id: '3', name: 'Wayne Enterprises', role: 'Viewer'),
    ];

    // Mock Projects (Initial Load)
    final projects = _getProjectsForOrg(organizations.first.id);

    emit(
      state.copyWith(
        organizations: organizations,
        selectedOrganization: organizations.first,
        projects: projects,
        selectedProject: projects[0], // "All Projects"
        isLoading: false,
      ),
    );
  }

  void _onSelectOrganization(
    SelectOrganization event,
    Emitter<DashboardState> emit,
  ) {
    if (event.organization == state.selectedOrganization) return;

    // When org changes, load projects for that org
    final projects = _getProjectsForOrg(event.organization.id);

    emit(
      state.copyWith(
        selectedOrganization: event.organization,
        projects: projects,
        selectedProject: null, // Reset project selection
      ),
    );
  }

  void _onSelectProject(SelectProject event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedProject: event.project));
  }

  List<Project> _getProjectsForOrg(String orgId) {
    // Mock data logic
    return [
      const Project(id: 'p1', name: 'Website Redesign', status: 'Active'),
      const Project(id: 'p2', name: 'Mobile App Beta', status: 'Active'),
      const Project(id: 'p3', name: 'Q4 Marketing', status: 'Archived'),
      const Project(id: 'p4', name: 'Internal Tools', status: 'Active'),
      const Project(id: 'p5', name: 'Legacy System', status: 'Archived'),
    ];
  }
}
