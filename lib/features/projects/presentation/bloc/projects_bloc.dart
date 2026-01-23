import 'package:flutter_bloc/flutter_bloc.dart';
import 'projects_event.dart';
import 'projects_state.dart';
import '../../data/models/project.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(const ProjectsState()) {
    on<LoadProjects>(_onLoadProjects);
    on<FilterProjects>(_onFilterProjects);
    on<SearchProjects>(_onSearchProjects);
    on<CreateProject>(_onCreateProject);
  }

  Future<void> _onLoadProjects(
    LoadProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Initially load empty list to show Empty State first (as requested or to demonstrate state)
    // Actually typically we load data. If list is empty, UI shows empty state.
    // Let's start with EMPTY list to show the "Project Directory" empty state first.
    // User can "Create Project" to populate it.

    emit(
      state.copyWith(
        status: ProjectsStatus.success,
        projects: Project.dummyData,
        filteredProjects: Project.dummyData,
      ),
    );
  }

  Future<void> _onCreateProject(
    CreateProject event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(status: ProjectsStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    final newProjects = Project.dummyData; // Load dummy data on creation
    emit(
      state.copyWith(
        status: ProjectsStatus.success,
        projects: newProjects,
        filteredProjects: newProjects,
        currentFilter: 'All',
      ),
    );
  }

  void _onFilterProjects(FilterProjects event, Emitter<ProjectsState> emit) {
    final filter = event.filter;
    List<Project> filtered;

    if (filter == 'All') {
      filtered = state.projects;
    } else {
      filtered = state.projects.where((p) => p.statusLabel == filter).toList();
    }

    // Also apply search if exists
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (p) =>
                p.name.toLowerCase().contains(
                  state.searchQuery.toLowerCase(),
                ) ||
                p.client.toLowerCase().contains(
                  state.searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    emit(state.copyWith(currentFilter: filter, filteredProjects: filtered));
  }

  void _onSearchProjects(SearchProjects event, Emitter<ProjectsState> emit) {
    final query = event.query;
    List<Project> filtered =
        state.projects; // Start from full list or currently filtered?
    // Usually search filters current view or global. Let's filter global for simplicity or respect tabs + search.
    // Let's respect tabs: first filter by tab, then by query.

    if (state.currentFilter != 'All') {
      filtered = filtered
          .where((p) => p.statusLabel == state.currentFilter)
          .toList();
    }

    if (query.isNotEmpty) {
      filtered = filtered
          .where(
            (p) =>
                p.name.toLowerCase().contains(query.toLowerCase()) ||
                p.client.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    emit(state.copyWith(searchQuery: query, filteredProjects: filtered));
  }
}
