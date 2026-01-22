import 'package:flutter/material.dart';
import '../../../../core/ui/app_text.dart';
import '../../../../src/src.dart';

class AdminDashboardContent extends StatelessWidget {
  const AdminDashboardContent({super.key});

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
                // Header
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 600;
                    return Flex(
                      direction: isSmall ? Axis.vertical : Axis.horizontal,
                      crossAxisAlignment: isSmall
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText.title(
                              'Organization Overview',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.sync,
                                  size: 14,
                                  color: AppColors.textSecondary.withAlpha(200),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Last updated: 2 minutes ago',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary.withAlpha(
                                      200,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (isSmall) const SizedBox(height: 16),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.download_outlined,
                                size: 18,
                              ),
                              label: const Text('Export Report'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(color: AppColors.border),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_add_outlined,
                                size: 18,
                              ),
                              label: const Text('Invite Member'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF1565C0,
                                ), // Blue like in image
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),

                // KPI Grid
                // KPI Grid - Responsive
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;

                    const double gap = 24.0;

                    if (width < 600) {
                      return const Column(
                        children: [
                          _KpiCard(
                            label: 'Total Employees',
                            value: '1,284',
                            trend: '~2.4%',
                            trendColor: Colors.green,
                            icon: Icons.people_outline,
                          ),
                          SizedBox(height: gap),
                          _KpiCard(
                            label: 'Active Users',
                            value: '92%',
                            trend: '~0.5%',
                            trendColor: Colors.green,
                            icon: Icons.person_outline,
                          ),
                          SizedBox(height: gap),
                          _KpiCard(
                            label: 'Pending Invites',
                            value: '14',
                            trend: '~12%',
                            trendColor: Colors.red,
                            trendPrefix: '↘',
                            icon: Icons.mail_outline,
                          ),
                          SizedBox(height: gap),
                          _KpiCard(
                            label: 'System Health',
                            value: 'HEALTHY',
                            valueFontSize: 20,
                            valueColor: AppColors.textPrimary,
                            subValue: '99.9%',
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                          ),
                        ],
                      );
                    }

                    if (width < 1000) {
                      return const Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _KpiCard(
                                  label: 'Total Employees',
                                  value: '1,284',
                                  trend: '~2.4%',
                                  trendColor: Colors.green,
                                  icon: Icons.people_outline,
                                ),
                              ),
                              SizedBox(width: gap),
                              Expanded(
                                child: _KpiCard(
                                  label: 'Active Users',
                                  value: '92%',
                                  trend: '~0.5%',
                                  trendColor: Colors.green,
                                  icon: Icons.person_outline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: gap),
                          Row(
                            children: [
                              Expanded(
                                child: _KpiCard(
                                  label: 'Pending Invites',
                                  value: '14',
                                  trend: '~12%',
                                  trendColor: Colors.red,
                                  trendPrefix: '↘',
                                  icon: Icons.mail_outline,
                                ),
                              ),
                              SizedBox(width: gap),
                              Expanded(
                                child: _KpiCard(
                                  label: 'System Health',
                                  value: 'HEALTHY',
                                  valueFontSize: 20,
                                  valueColor: AppColors.textPrimary,
                                  subValue: '99.9%',
                                  icon: Icons.check_circle,
                                  iconColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    return const Row(
                      children: [
                        Expanded(
                          child: _KpiCard(
                            label: 'Total Employees',
                            value: '1,284',
                            trend: '~2.4%',
                            trendColor: Colors.green, // AppColors.success
                            icon: Icons.people_outline,
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _KpiCard(
                            label: 'Active Users',
                            value: '92%',
                            trend: '~0.5%',
                            trendColor: Colors.green,
                            icon: Icons.person_outline,
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _KpiCard(
                            label: 'Pending Invites',
                            value: '14',
                            trend: '~12%',
                            trendColor: Colors.red,
                            trendPrefix: '↘',
                            icon: Icons.mail_outline,
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _KpiCard(
                            label: 'System Health',
                            value: 'HEALTHY',
                            valueFontSize: 20,
                            valueColor: AppColors.textPrimary,
                            subValue: '99.9%',
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Main Layout (2 Columns) - Responsive
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 900) {
                      return Column(
                        children: [
                          _buildLeftColumn(),
                          const SizedBox(height: 32),
                          _buildRightColumn(),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column (Attention & Activity)
                        Expanded(flex: 2, child: _buildLeftColumn()),
                        const SizedBox(width: 24),
                        // Right Column (Quick Actions & Analytics)
                        Expanded(flex: 1, child: _buildRightColumn()),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      children: [
        // Attention Required
        _SectionHeader(
          title: 'Attention Required',
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.orange,
          action: TextButton(
            onPressed: () {},
            child: const Text('View All Task', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(height: 12),
        _AttentionItem(
          icon: Icons.person_add_alt_1,
          iconColor: Colors.orange,
          iconBg: Colors.orange.withAlpha(25),
          title: 'Pending Onboardings',
          subtitle: '5 employees awaiting access configuration',
          actionLabel: 'Process',
          actionColor: const Color(0xFF1565C0),
        ),
        const SizedBox(height: 12),
        _AttentionItem(
          icon: Icons.security,
          iconColor: Colors.blue,
          iconBg: Colors.blue.withAlpha(25),
          title: 'Access Review Due',
          subtitle: 'Engineering team quarterly permission audit',
          actionLabel: 'Start Review',
          isOutlined: true,
        ),
        const SizedBox(height: 12),
        _AttentionItem(
          icon: Icons.error_outline,
          iconColor: Colors.red,
          iconBg: Colors.red.withAlpha(25),
          title: 'Suspicious Login',
          subtitle: "Unusual IP detected for user 'm_chen@acme.com'",
          actionLabel: 'Investigate',
          actionColor: const Color(0xFFD32F2F), // Red
        ),

        const SizedBox(height: 32),

        // Recent Activity Feed
        const _SectionHeader(
          title: 'Recent Activity Feed',
          icon: Icons.list_alt,
          action: Icon(
            Icons.filter_list,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              const _ActivityItem(
                avatarUrl:
                    'https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg?semt=ais_hybrid&w=740&q=80',
                content: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sarah Jenkins',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    TextSpan(text: ' updated the Global Security Policy.'),
                  ],
                ),
                timestamp: '2 minutes ago • Security',
              ),
              const Divider(height: 32),
              const _ActivityItem(
                avatarUrl:
                    'https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg?semt=ais_hybrid&w=740&q=80',
                content: TextSpan(
                  children: [
                    TextSpan(
                      text: 'James Wilson',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    TextSpan(text: ' was assigned to '),
                    TextSpan(
                      text: 'Admin Manager',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Color(0xFFEEEEEE),
                      ),
                    ),
                    TextSpan(text: ' role.'),
                  ],
                ),
                timestamp: '45 minutes ago • IAM',
              ),
              const Divider(height: 32),
              const _ActivityItem(
                avatarUrl:
                    'https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg?semt=ais_hybrid&w=740&q=80',
                content: TextSpan(
                  children: [
                    TextSpan(
                      text: 'System',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    TextSpan(text: ' automatically revoked access for '),
                    TextSpan(
                      text: 'temp_contractor_04',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
                timestamp: '2 hours ago • Automation',
              ),
              const Divider(height: 32),
              const _ActivityItem(
                avatarUrl:
                    'https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg?semt=ais_hybrid&w=740&q=80',
                content: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Lila Chen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    TextSpan(text: ' exported the Monthly Audit Report.'),
                  ],
                ),
                timestamp: '5 hours ago • Reports',
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('View Full Audit Log'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      children: [
        const _SectionHeader(title: 'Quick Admin Actions'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: const Column(
            children: [
              _QuickActionItem(
                icon: Icons.person_add_alt,
                title: 'Invite Employee',
                subtitle: 'Add a single or bulk users',
                color: Colors.blue,
              ),
              Divider(height: 1),
              _QuickActionItem(
                icon: Icons.vpn_key_outlined,
                title: 'Reset Credentials',
                subtitle: 'Manage user password & MFA',
                color: Colors.blue,
              ),
              Divider(height: 1),
              _QuickActionItem(
                icon: Icons.verified_user_outlined,
                title: 'Create New Role',
                subtitle: 'Define custom permission set',
                color: Colors.blue,
              ),
              Divider(height: 1),
              _QuickActionItem(
                icon: Icons.sync,
                title: 'Force Sync Directory',
                subtitle: 'Update from Azure AD/Okta',
                color: Colors.blue,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const _SectionHeader(title: 'Usage Analytics'),
        const SizedBox(height: 12),
        Container(
          height: 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.bar_chart, size: 32, color: Colors.blue),
                    SizedBox(height: 8),
                    Text(
                      'ACTIVE SESSIONS 24H',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PEAK TIME',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        '10:00 AM EST',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AVG. LOAD',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        '24.2ms',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Widget? action;

  const _SectionHeader({
    required this.title,
    this.icon,
    this.iconColor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: iconColor ?? AppColors.textPrimary),
          const SizedBox(width: 8),
        ],
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subValue;
  final double? valueFontSize;
  final Color? valueColor;
  final String? trend;
  final String? trendPrefix;
  final Color? trendColor;
  final IconData
  icon; // Used as top right icon? Or implied? Code had implied. Image shows top right icon.
  final Color? iconColor;

  const _KpiCard({
    required this.label,
    required this.value,
    this.subValue,
    this.valueFontSize,
    this.valueColor,
    this.trend,
    this.trendPrefix,
    this.trendColor,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xFF1565C0,
                  ), // Blueish tint for headers in image? Or grey. Let's use blueish grey.
                ),
              ),
              Icon(icon, color: iconColor ?? const Color(0xFF455A64), size: 18),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: valueFontSize ?? 32,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? AppColors.textPrimary,
                ),
              ),
              if (subValue != null) ...[
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    subValue!,
                    style: TextStyle(
                      fontSize: 16,
                      color: trendColor ?? AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
              if (trend != null) ...[
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '${trendPrefix ?? ''}$trend',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: trendColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _AttentionItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String actionLabel;
  final Color? actionColor;
  final bool isOutlined;

  const _AttentionItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.actionColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          if (isOutlined)
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.border),
              ),
              child: Text(actionLabel),
            )
          else
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: actionColor,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: Text(actionLabel),
            ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String avatarUrl;
  final TextSpan content;
  final String timestamp;

  const _ActivityItem({
    required this.avatarUrl,
    required this.content,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  children: [content],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timestamp,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _QuickActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
