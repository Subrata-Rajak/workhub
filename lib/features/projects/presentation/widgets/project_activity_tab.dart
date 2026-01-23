import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class ProjectActivityTab extends StatelessWidget {
  const ProjectActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _FilterChip(label: 'All Activities', isSelected: true),
                  const SizedBox(width: 12),
                  _FilterChip(label: 'Member Changes'),
                  const SizedBox(width: 12),
                  _FilterChip(label: 'Status Updates'),
                  const SizedBox(width: 12),
                  _FilterChip(label: 'Settings'),
                ],
              ),
              const Text(
                'Showing 1-50 of 2,481 events',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 32),

          const Text(
            'TODAY — OCT 26, 2023',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          _TimelineItem(
            time: '14:22:05',
            content: RichText(
              text: const TextSpan(
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Sarah Miller',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: ' updated project status'),
                ],
              ),
            ),
            extra: Row(
              children: [
                Text(
                  'In Progress',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_alt,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'On Hold',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '"Waiting for hardware delivery"',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            icon: Icons.sync_alt,
            color: Colors.orange,
          ),
          _TimelineItem(
            time: '11:05:41',
            content: RichText(
              text: const TextSpan(
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Mark Chen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: ' added '),
                  TextSpan(
                    text: 'Elena Rodriguez',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' to the '),
                  TextSpan(
                    text: 'Dev-Lead',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: ' role'),
                ],
              ),
            ),
            icon: Icons.person_add,
            color: Colors.blue,
          ),
          _TimelineItem(
            time: '09:15:22',
            content: RichText(
              text: const TextSpan(
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'System Admin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' modified auto-archive settings'),
                ],
              ),
            ),
            extra: const Text(
              'Retain logs: 90 days → 180 days',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            icon: Icons.settings,
            color: Colors.purple,
          ),

          const SizedBox(height: 32),
          const Text(
            'YESTERDAY — OCT 25, 2023',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),

          _TimelineItem(
            time: '16:45:10',
            content: RichText(
              text: const TextSpan(
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Sarah Miller',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: ' completed milestone: '),
                  TextSpan(
                    text: 'Phase 1 - Requirements',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          _TimelineItem(
            time: '13:12:04',
            content: RichText(
              text: const TextSpan(
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'James Wilson',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: ' attached '),
                  TextSpan(
                    text: 'network-topology-v2.pdf',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            icon: Icons.attach_file,
            color: Colors.grey,
          ),

          const SizedBox(height: 48),
          Center(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.history),
              label: const Text('Load More History'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              '© 2023 WorkHub Internal Systems. Operational Audit Log.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
        border: isSelected
            ? Border.all(color: Colors.blue.withOpacity(0.2))
            : null,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.blue),
          ],
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String time;
  final Widget content;
  final Widget? extra;
  final IconData icon;
  final Color color;

  const _TimelineItem({
    required this.time,
    required this.content,
    this.extra,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Line
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 12, color: color),
              ),
              Expanded(child: Container(width: 1, color: Colors.grey[200])),
            ],
          ),
          const SizedBox(width: 16),
          // Time
          SizedBox(
            width: 60,
            child: Text(
              time,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                if (extra != null) ...[const SizedBox(height: 4), extra!],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
