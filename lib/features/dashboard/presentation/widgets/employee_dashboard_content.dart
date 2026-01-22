import 'package:flutter/material.dart';
import '../../../../core/ui/app_text.dart';
import '../../../../src/src.dart';

class EmployeeDashboardContent extends StatelessWidget {
  const EmployeeDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Hide Scrollbar
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText.title(
                  'Good Morning, Jane',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm), // 8
                const AppText.body(
                  "Here's what's happening today.",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl), // 32
                // My Projects / Activity
                const AppText.header(
                  AppStrings.myProjects,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: _ProjectCard(
                        title: 'Website Redesign',
                        status: 'In Progress',
                        progress: 0.7,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md), // 24
                    Expanded(
                      child: _ProjectCard(
                        title: 'Q4 Marketing Campaign',
                        status: 'Planning',
                        progress: 0.2,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md), // 24
                    Expanded(
                      child: _ProjectCard(
                        title: 'Mobile App Beta',
                        status: 'Completed',
                        progress: 1.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl), // 48
                const AppText.header(
                  AppStrings.recentUpdates,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.md), // 16
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg), // 24
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    children: [
                      _UpdateItem(
                        user: 'Alex Rivera',
                        action: 'commented on',
                        target: 'Homepage Design v2',
                        time: '2 hours ago',
                      ),
                      Divider(height: AppSpacing.xxl), // 32
                      _UpdateItem(
                        user: 'Sarah Chen',
                        action: 'uploaded',
                        target: 'Q3 Financial Report.pdf',
                        time: '5 hours ago',
                      ),
                      Divider(height: AppSpacing.xxl), // 32
                      _UpdateItem(
                        user: 'Mike Ross',
                        action: 'completed task',
                        target: 'Update privacy policy',
                        time: 'Yesterday',
                      ),
                    ],
                  ),
                ),
              ],
            ), // Column
          ), // ConstrainedBox
        ), // Center
      ), // SingleChildScrollView
    ); // ScrollConfiguration
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final double progress;
  final MaterialColor color;

  const _ProjectCard({
    required this.title,
    required this.status,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg), // 24
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppElevation.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.folder_outlined, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppText.header(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.md), // 16
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.surfaceAlt, // grey[100]
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}

class _UpdateItem extends StatelessWidget {
  final String user;
  final String action;
  final String target;
  final String time;

  const _UpdateItem({
    required this.user,
    required this.action,
    required this.target,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.indigo[50],
          child: Text(
            user[0],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[700],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ), // 1F2937
              children: [
                TextSpan(
                  text: user,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' '),
                TextSpan(text: action),
                const TextSpan(text: ' '),
                TextSpan(
                  text: target,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Text(
          time,
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ), // grey[500]
      ],
    );
  }
}
