import 'package:equatable/equatable.dart';
import '../../data/models/project.dart';

enum ProjectsStatus { initial, loading, success, failure }

class ProjectsState extends Equatable {
  final ProjectsStatus status;
  final List<Project> projects;
  final List<Project> filteredProjects;
  final String currentFilter;
  final String searchQuery;

  const ProjectsState({
    this.status = ProjectsStatus.initial,
    this.projects = const [],
    this.filteredProjects = const [],
    this.currentFilter = 'All',
    this.searchQuery = '',
  });

  ProjectsState copyWith({
    ProjectsStatus? status,
    List<Project>? projects,
    List<Project>? filteredProjects,
    String? currentFilter,
    String? searchQuery,
  }) {
    return ProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [
    status,
    projects,
    filteredProjects,
    currentFilter,
    searchQuery,
  ];
}
