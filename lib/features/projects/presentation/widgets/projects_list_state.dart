import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src/src.dart';
import '../../../../core/routing/route_paths.dart';
import '../../data/models/project.dart';
import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';

class ProjectsListState extends StatelessWidget {
  final List<Project> projects;
  final String currentFilter;

  const ProjectsListState({
    super.key,
    required this.projects,
    required this.currentFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Filters & Search Bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(child: _ProjectFilterTabs(currentFilter: currentFilter)),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search projects, clients...',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) =>
                      context.read<ProjectsBloc>().add(SearchProjects(value)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Table Header
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              _HeaderCell('PROJECT NAME', flex: 3),
              _HeaderCell('CLIENT', flex: 2),
              _HeaderCell('STATUS', flex: 2),
              _HeaderCell('TEAM', flex: 2),
              _HeaderCell('LAST UPDATED', flex: 2),
              _HeaderCell('ACTIONS', flex: 1, alignment: Alignment.centerRight),
            ],
          ),
        ),
        const Divider(height: 1),

        // List Items
        Expanded(
          child: ListView.separated(
            itemCount: projects.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final project = projects[index];
              return _ProjectRow(project: project);
            },
          ),
        ),

        // Footer / Pagination
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing 1-${projects.length} of 24 projects',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectFilterTabs extends StatelessWidget {
  final String currentFilter;

  const _ProjectFilterTabs({required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Active', 'On Hold', 'Completed', 'Archived'];
    return Row(
      children: tabs.map((tab) {
        final isSelected = currentFilter == (tab == 'All' ? 'All' : tab);
        return GestureDetector(
          onTap: () {
            context.read<ProjectsBloc>().add(FilterProjects(tab));
          },
          child: Container(
            margin: const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: isSelected
                  ? const Border(
                      bottom: BorderSide(color: AppColors.primary, width: 2),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Text(
                  tab,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
                if (tab == 'All') ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '24',
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  final Alignment alignment;

  const _HeaderCell(
    this.label, {
    required this.flex,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: alignment,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B7280), // Gray 500
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final Project project;

  const _ProjectRow({required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        RoutePaths.projectDetails.replaceAll(':projectId', project.id),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 16,
        ),
        child: Row(
          children: [
            // Project Name
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    project.code,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Client
            Expanded(
              flex: 2,
              child: Text(
                project.client,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),

            // Status
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: project.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    project.statusLabel,
                    style: TextStyle(
                      color: project.statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Team
            Expanded(
              flex: 2,
              child: Row(children: [_AvatarStack(team: project.team)]),
            ),

            // Last Updated
            Expanded(
              flex: 2,
              child: Text(
                _formatLastUpdated(project.lastUpdated),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),

            // Actions
            const Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.more_vert, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatLastUpdated(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${diff.inDays ~/ 7} weeks ago';
  }
}

class _AvatarStack extends StatelessWidget {
  final List<String> team;
  const _AvatarStack({required this.team});

  @override
  Widget build(BuildContext context) {
    final visible = team.take(2).toList();
    final remaining = team.length - 2;

    final count = visible.length + (remaining > 0 ? 1 : 0);
    final width = count == 0 ? 0.0 : (count - 1) * 24.0 + 32.0;

    return SizedBox(
      height: 32,
      width: width,
      child: Stack(
        children: [
          for (var i = 0; i < visible.length; i++)
            Positioned(
              left: i * 24.0,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primary.withOpacity(
                    0.8 - (i * 0.2),
                  ),
                  child: Text(
                    visible[i],
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ),

          if (remaining > 0)
            Positioned(
              left: visible.length * 24.0,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    '+$remaining',
                    style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
