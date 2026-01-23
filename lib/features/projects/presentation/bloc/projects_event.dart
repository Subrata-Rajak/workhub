import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

class LoadProjects extends ProjectsEvent {}

class FilterProjects extends ProjectsEvent {
  final String filter; // 'All', 'Active', 'On Hold', 'Completed', 'Archived'

  const FilterProjects(this.filter);

  @override
  List<Object> get props => [filter];
}

class SearchProjects extends ProjectsEvent {
  final String query;

  const SearchProjects(this.query);

  @override
  List<Object> get props => [query];
}

class CreateProject extends ProjectsEvent {
  // In a real app, this would take parameters
  const CreateProject();
}
