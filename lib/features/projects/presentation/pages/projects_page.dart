import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/app_text.dart';
import '../../../../src/src.dart';
import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';
import '../bloc/projects_state.dart';
import '../widgets/projects_empty_state.dart';
import '../widgets/projects_list_state.dart';
import '../../../../core/di/injection_container.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProjectsBloc>()..add(LoadProjects()),
      child: const ProjectsView(),
    );
  }
}

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        final isEmpty = state.projects.isEmpty;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Dynamic Header based on state
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.header(
                          isEmpty ? 'Project Directory' : 'Projects',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AppText.body(
                          isEmpty
                              ? '0 Projects active'
                              : 'Manage and monitor all internal IT initiatives',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    if (!isEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<ProjectsBloc>().add(
                            const CreateProject(),
                          );
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Create Project'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Content Switcher
                Expanded(
                  child: state.status == ProjectsStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : isEmpty
                      ? const ProjectsEmptyState()
                      : ProjectsListState(
                          projects: state.filteredProjects,
                          currentFilter: state.currentFilter,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
