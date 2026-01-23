import 'package:flutter/material.dart';
import '../../../../src/src.dart';
import '../widgets/task_board_view.dart';
import '../widgets/task_list_view.dart';
import '../widgets/task_timeline_view.dart';
import '../widgets/create_task_modal.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String _currentView = 'BOARD'; // BOARD, LIST, TIMELINE

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Header
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              // View Switcher
              _ViewTab(
                icon: Icons.grid_view_outlined, // Placeholder for Board icon
                label: 'BOARD',
                isActive: _currentView == 'BOARD',
                onTap: () => setState(() => _currentView = 'BOARD'),
              ),
              const SizedBox(width: 24),
              _ViewTab(
                icon: Icons.list_outlined,
                label: 'LIST',
                isActive: _currentView == 'LIST',
                onTap: () => setState(() => _currentView = 'LIST'),
              ),
              const SizedBox(width: 24),
              _ViewTab(
                icon: Icons.timeline_outlined, // Placeholder
                label: 'TIMELINE',
                isActive: _currentView == 'TIMELINE',
                onTap: () => setState(() => _currentView = 'TIMELINE'),
              ),

              const Spacer(),

              // Right side actions
              // Avatars Placeholder
              SizedBox(
                height: 32,
                child: Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Align(
                        widthFactor: 0.7,
                        child: _AvatarPlaceholder(
                          initials: i == 0
                              ? 'JD'
                              : i == 1
                              ? 'AM'
                              : '+12',
                          color: i == 0
                              ? Colors.blue
                              : i == 1
                              ? Colors.green
                              : Colors.grey,
                          isCount: i == 2,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flash_on_rounded, size: 18),
                label: const Text('Create Sprint'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withAlpha(50),
                    builder: (context) => const CreateTaskModal(),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create Issue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Filters Bar (Visible for all views)
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              const _FilterButton(label: 'Sprint: Sprint 24 - Q3 Infra'),
              const SizedBox(width: 12),
              const _FilterButton(label: 'Priority'),
              const SizedBox(width: 12),
              const _FilterButton(label: 'Assignee'),
              const SizedBox(width: 16),
              Container(width: 1, height: 24, color: AppColors.border),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list_off,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                label: const Text(
                  'Clear Filters',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content Area
        Expanded(
          child: _currentView == 'BOARD'
              ? const TaskBoardView()
              : _currentView == 'LIST'
              ? const TaskListView()
              : const TaskTimelineView(),
        ),
      ],
    );
  }
}

class _ViewTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ViewTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;

  const _FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final String initials;
  final Color color;
  final bool isCount;

  const _AvatarPlaceholder({
    required this.initials,
    required this.color,
    this.isCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: isCount ? AppColors.textPrimary : Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
