import 'package:flutter/material.dart';
import '../../../../core/ui/app_text.dart';
import '../../../../src/src.dart';
import '../widgets/animated_tab_selector.dart';
import '../widgets/invite_member_sheet.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 1000;
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl), // 32
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Flex(
                  direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: isSmallScreen
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.verified,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            SizedBox(width: AppSpacing.sm), // 8
                            Text(
                              'ACME CORP WORKSPACE', // Keeping branding string as literal or move? "ACME CORP" is topbar string. WORKSPACE is generic. I'll leave as literal for this specific page header for now as it seems dynamic in real app.
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors
                                    .primary, // Teal[800] -> primary (Teal)
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.sm), // 8
                        AppText.title(
                          AppStrings.membersTitle,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm), // 8
                        AppText.body(
                          AppStrings.membersSubtitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    if (isSmallScreen) const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download, size: 18),
                          label: const Text(AppStrings.exportCsv),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(
                              color: AppColors.border,
                            ), // grey[300] isn't exact border (grey[200]) but close. I'll use border color.
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.md, // 16
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md), // 16
                        ElevatedButton.icon(
                          onPressed: () {
                            InviteMemberSheet.show(context);
                          },
                          icon: const Icon(Icons.person_add, size: 18),
                          label: const Text(AppStrings.sendInvite),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.textInverse,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.md,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl), // 32
                // Summary Cards
                if (isSmallScreen) ...[
                  const _SummaryCard(
                    label: AppStrings.kpiTotalMembers,
                    value: '128',
                    trend: '+12% this month',
                    trendColor: AppColors.success,
                    icon: Icons.group,
                    color: Colors.teal,
                  ),
                  const SizedBox(height: 16),
                  const _SummaryCard(
                    label: AppStrings.kpiSystemStatus,
                    value: 'Healthy',
                    subValue: 'All services operational',
                    subValueColor: AppColors.success,
                    icon: Icons.local_hospital,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  const _SummaryCard(
                    label: AppStrings.kpiPendingInvites,
                    value: '5',
                    subValue: 'Requires follow-up',
                    icon: Icons.mail_outline,
                    color: Colors.orange,
                  ),
                ] else
                  const Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          label: AppStrings.kpiTotalMembers,
                          value: '128',
                          trend: '+12% this month',
                          trendColor: AppColors.success,
                          icon: Icons.group,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(width: AppSpacing.lg), // 24
                      Expanded(
                        child: _SummaryCard(
                          label: AppStrings.kpiSystemStatus,
                          value: 'Healthy',
                          subValue: 'All services operational',
                          subValueColor: AppColors.success,
                          icon: Icons.local_hospital,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: AppSpacing.lg), // 24
                      Expanded(
                        child: _SummaryCard(
                          label: AppStrings.kpiPendingInvites,
                          value: '5',
                          subValue: 'Requires follow-up',
                          icon: Icons.mail_outline,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: AppSpacing.xl), // 32
                // Table Section
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: AppElevation.card,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: isSmallScreen
                          ? 900
                          : constraints.maxWidth - (AppSpacing.xl * 2),
                      child: Column(
                        children: [
                          // Filter Bar
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Row(
                              children: [
                                // Animated Tabs
                                AnimatedTabSelector(
                                  tabs: const ['All', 'Active', 'Pending'],
                                  initialIndex: _selectedTabIndex,
                                  onTabSelected: (index) {
                                    setState(() {
                                      _selectedTabIndex = index;
                                    });
                                    // TODO: Filter members based on selected tab
                                  },
                                ),
                                const Spacer(),
                                const Text(
                                  'Showing 1-10 of 128',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                // Pagination
                                Row(
                                  children: [
                                    _PaginationButton(
                                      icon: Icons.chevron_left,
                                      onTap: () {},
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    _PaginationButton(
                                      icon: Icons.chevron_right,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          // Table Headers
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'NAME',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'ROLE',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'STATUS',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textMuted,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'LAST ACTIVE',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 48,
                                ), // Action column placeholder
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          // Table Rows
                          const _MemberRow(
                            name: 'Alex Rivera',
                            email: 'alex@acmecorp.com',
                            role: 'Editor',
                            status: 'Active',
                            lastActive: '2 hours ago',
                            avatarColor: Colors.blue,
                          ),
                          const Divider(height: 1),
                          const _MemberRow(
                            name: 'Jordan Smith',
                            email: 'jordan.s@acmecorp.com',
                            role: 'Admin',
                            status: 'Active',
                            lastActive: '14 mins ago',
                            avatarColor: Colors.purple,
                          ),
                          const Divider(height: 1),
                          const _MemberRow(
                            name: 'Casey Lane',
                            email: 'casey@acmecorp.com',
                            role: 'Viewer',
                            status: 'Pending',
                            lastActive: 'Invite sent 3d ago',
                            statusColor: Colors.orange,
                            avatarColor: Colors.grey,
                            isPending: true,
                          ),
                          // Add more placeholders if needed
                        ],
                      ),
                    ),
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

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subValue;
  final Color? subValueColor;
  final String? trend;
  final Color? trendColor;
  final IconData icon;
  final Color
  color; // Changed from MaterialColor to Color for flexibility with AppColors

  const _SummaryCard({
    required this.label,
    required this.value,
    this.subValue,
    this.subValueColor,
    this.trend,
    this.trendColor,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.body(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              AppText.title(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary, // 1F2937
                ),
              ),
              if (trend != null) ...[
                const SizedBox(height: 8),
                Text(
                  trend!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ],
              if (subValue != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (subValueColor != null) ...[
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: subValueColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    AppText.body(
                      subValue!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(20), // Very light tint
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _PaginationButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 16, color: Colors.grey[600]),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String status;
  final String lastActive;
  final Color avatarColor;
  final Color? statusColor;
  final bool isPending;

  const _MemberRow({
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.lastActive,
    required this.avatarColor,
    this.statusColor,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverableRow(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: avatarColor.withAlpha(40),
                    child: isPending
                        ? const Icon(Icons.person_outline, color: Colors.grey)
                        : Text(
                            name[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: avatarColor,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Text(
                    role,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: statusColor ?? Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                lastActive,
                style: TextStyle(fontSize: 13, color: Colors.grey[500]),
              ),
            ),
            SizedBox(
              width: 48,
              child: IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.grey),
                onPressed: () {},
                splashRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverableRow extends StatefulWidget {
  final Widget child;
  const HoverableRow({super.key, required this.child});

  @override
  State<HoverableRow> createState() => _HoverableRowState();
}

class _HoverableRowState extends State<HoverableRow> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        color: _isHovering ? Colors.grey[50] : Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
