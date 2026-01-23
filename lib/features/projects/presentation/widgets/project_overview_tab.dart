import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class ProjectOverviewTab extends StatelessWidget {
  const ProjectOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column (Description + Metrics)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildCard(
                  title: 'Project Description',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'The Cloud Migration 2024 project focuses on transitioning our core legacy on-premise server infrastructure to a scalable AWS architecture. This initiative aims to improve system uptime by 99.99%, reduce operational costs by 25% over three years, and enable faster deployment pipelines for the engineering teams.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Overall Completion',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '64%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.64,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue[700]!,
                        ),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  title: 'Detailed Metrics',
                  child: Column(
                    children: const [
                      _MetricRow(
                        label: 'Infrastructure Target',
                        value: 'AWS US-East-1',
                      ),
                      SizedBox(height: 16),
                      _MetricRow(
                        label: 'Compliance Standard',
                        value: 'SOC2 Type II',
                      ),
                      SizedBox(height: 16),
                      _MetricRow(
                        label: 'Budget Allocation',
                        value: '\$450,000 USD',
                      ),
                      SizedBox(height: 16),
                      _MetricRow(
                        label: 'Estimated Completion',
                        value: 'Oct 12, 2024',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right Column (Activity + Assets)
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildCard(
                  title: 'Recent Activity',
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                  child: Column(
                    children: [
                      _ActivityItem(
                        icon: Icons.refresh,
                        color: Colors.blue,
                        text: 'John Doe updated PRJ-102',
                        subtext: 'Migration script v2.1 uploaded',
                        time: '2 HOURS AGO',
                      ),
                      SizedBox(height: 16),
                      _ActivityItem(
                        icon: Icons.check_circle,
                        color: Colors.green,
                        text: 'System check completed',
                        subtext: 'Phase 1 staging environment verified',
                        time: '5 HOURS AGO',
                      ),
                      SizedBox(height: 16),
                      _ActivityItem(
                        icon: Icons.flag,
                        color: Colors.orange,
                        text: 'Milestone 2 reached',
                        subtext: 'Database migration plan approved',
                        time: 'YESTERDAY',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildCard(
                  title: 'Project Assets',
                  child: Column(
                    children: [
                      _AssetItem(
                        icon: Icons.description,
                        text: 'Technical Specification.pdf',
                      ),
                      const SizedBox(height: 12),
                      _AssetItem(
                        icon: Icons.link,
                        text: 'AWS Architecture Diagram',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
    Widget? action,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final String value;
  const _MetricRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String subtext;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.color,
    required this.text,
    required this.subtext,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtext,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AssetItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _AssetItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
