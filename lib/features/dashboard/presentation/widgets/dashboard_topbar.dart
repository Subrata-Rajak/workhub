import 'package:flutter/material.dart';
import '../../../../src/src.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc/dashboard_bloc.dart';
import '../../data/models/organization.dart';
import '../../data/models/project.dart';
import 'switcher_modal.dart';
import '../../../global_search/presentation/widgets/global_search_modal.dart';

class DashboardTopbar extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenuIcon;

  const DashboardTopbar({super.key, this.onMenuTap, this.showMenuIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, // AppSpacing.xxxl
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 900;
          return Row(
            children: [
              if (showMenuIcon) ...[
                IconButton(
                  onPressed: onMenuTap,
                  icon: const Icon(Icons.menu, color: AppColors.textSecondary),
                  tooltip: 'Open Sidebar (Ctrl+B)',
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    'WorkHub',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
              // Org Switcher
              if (!isSmallScreen) ...[
                const _OrgSwitcher(),
                const SizedBox(width: 12),
              ],
              // Project Switcher
              const _ProjectSwitcher(),
              const SizedBox(width: 24),

              // Centered Search (Responsive)
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: GestureDetector(
                      onTap: () {
                        // Import will be added at the top
                        showGlobalSearchModal(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: AppColors.textMuted,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                AppStrings.topbarSearchHintExpanded,
                                style: TextStyle(
                                  color: AppColors.textMuted.withAlpha(200),
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),

              // Right Actions
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help_outline,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),

              // Profile
              Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Alex Rivera',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.info.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.info.withAlpha(50),
                            ),
                          ),
                          child: const Text(
                            AppStrings.topbarAdminLabel,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: AppColors.info,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.border,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg?semt=ais_hybrid&w=740&q=80',
                      ), // Placeholder
                      child: Align(
                        alignment: Alignment.bottomRight,
                        // Online indicator could go here
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _OrgSwitcher extends StatelessWidget {
  const _OrgSwitcher();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (blocContext, state) {
        final selectedOrg = state.selectedOrganization;
        return InkWell(
          onTap: () {
            showDialog(
              context: blocContext,
              builder: (dialogContext) => BlocProvider.value(
                value: blocContext.read<DashboardBloc>(),
                child: SwitcherModal<Organization>(
                  title: AppStrings.selectOrganization,
                  items: state.organizations,
                  selectedItem: selectedOrg,
                  onSelected: (org) => blocContext.read<DashboardBloc>().add(
                    SelectOrganization(org),
                  ),
                  itemBuilder: (blocContext, org, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withAlpha(25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              org.name[0].toUpperCase(),
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.surface
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  org.name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  org.role,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: AppColors.primary,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.orgLabelShort,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary.withAlpha(200),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  selectedOrg?.name ?? AppStrings.selectOrgPlaceholder,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.unfold_more,
                  size: 16,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProjectSwitcher extends StatelessWidget {
  const _ProjectSwitcher();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (blocContext, state) {
        final selectedProject = state.selectedProject;
        return InkWell(
          onTap: () {
            showDialog(
              context: blocContext,
              builder: (dialogContext) => BlocProvider.value(
                value: blocContext.read<DashboardBloc>(),
                child: SwitcherModal<Project>(
                  title: AppStrings.selectProject,
                  items: state.projects,
                  selectedItem: selectedProject,
                  onSelected: (project) => blocContext
                      .read<DashboardBloc>()
                      .add(SelectProject(project)),
                  itemBuilder: (blocContext, project, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withAlpha(25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder_outlined,
                            size: 20,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  project.status,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: project.status == 'Active'
                                        ? AppColors.success
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: AppColors.primary,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.grid_view,
                  size: 16,
                  color: AppColors.primary.withAlpha(200),
                ),
                const SizedBox(width: 8),
                Text(
                  selectedProject?.name ?? AppStrings.allProjects,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.unfold_more,
                  size: 16,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
