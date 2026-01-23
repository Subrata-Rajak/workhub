import 'package:flutter/material.dart';

import '../../../../src/src.dart';

class DashboardSidebar extends StatelessWidget {
  final VoidCallback? onDashboardTap;
  final VoidCallback? onMembersTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onTasksTap;
  final VoidCallback? onRolesTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onAuditLogsTap; // Added
  final VoidCallback? onClose; // Added
  final String currentView;

  const DashboardSidebar({
    super.key,
    this.onDashboardTap,
    this.onMembersTap,
    this.onProjectsTap,
    this.onTasksTap,
    this.onRolesTap,
    this.onSettingsTap,
    this.onAuditLogsTap,
    this.onClose,
    this.currentView = 'admin',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.sidebarWidth,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Area
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.hub_outlined, // Changed to a more "hub" like icon
                    color: AppColors.textInverse,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WorkHub',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Operational Suite',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary.withAlpha(200),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.keyboard_double_arrow_left,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  tooltip: 'Collapse Sidebar (Ctrl+B)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Main Navigation
          _SidebarItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            isActive: currentView == 'admin',
            onTap: onDashboardTap,
          ),
          _SidebarItem(
            icon: Icons.people_outline,
            label: 'Members',
            isActive: currentView == 'members',
            onTap: onMembersTap,
          ),
          _SidebarItem(
            icon: Icons.folder_outlined,
            label: 'Projects',
            isActive: currentView == 'projects',
            onTap: onProjectsTap,
          ),
          _SidebarItem(
            icon: Icons.check_circle_outline, // Tasks icon
            label: 'Tasks',
            isActive: currentView == 'tasks',
            onTap: onTasksTap,
          ),
          _SidebarItem(
            icon: Icons.shield_outlined,
            label: 'Roles & Permissions',
            isActive: currentView == 'roles',
            onTap: onRolesTap,
          ),
          _SidebarItem(
            icon: Icons.settings_outlined,
            label: 'Org Settings',
            isActive: currentView == 'settings',
            onTap: onSettingsTap,
          ),

          const SizedBox(height: 24),

          // System Logs Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              'SYSTEM LOGS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
                letterSpacing: 1.0,
              ),
            ),
          ),
          _SidebarItem(
            icon: Icons.history,
            label: 'Audit Logs',
            isActive: currentView == 'audit_logs',
            onTap: onAuditLogsTap,
          ),

          const Spacer(),
          // Bottom Items (Optional support/profile link could go here, keeping empty for now relative to image)
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withAlpha(25)
              : Colors.transparent, // Lighter active bg
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
