import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class RolesAndPermissionsPage extends StatefulWidget {
  const RolesAndPermissionsPage({super.key});

  @override
  State<RolesAndPermissionsPage> createState() =>
      _RolesAndPermissionsPageState();
}

class _RolesAndPermissionsPageState extends State<RolesAndPermissionsPage> {
  String _selectedRole = 'IT Administrator';
  final List<String> _roles = [
    'IT Administrator',
    'HR Manager',
    'Junior Developer',
    'Security Officer',
    'Support Lead',
    'External Auditor',
  ];

  late List<_PermissionItem> _systemPermissions;
  late List<_PermissionItem> _accessPermissions;

  @override
  void initState() {
    super.initState();
    _systemPermissions = [
      _PermissionItem(
        title: 'System Audit Logs',
        subtitle: 'View and export all system activity and security logs',
        isEnabled: true,
      ),
      _PermissionItem(
        title: 'API Key Management',
        subtitle: 'Create, revoke, and manage production API credentials',
        isEnabled: true,
      ),
      _PermissionItem(
        title: 'Global Configuration',
        subtitle: 'Modify tenant settings, domains, and global integrations',
        isBadged: true,
        isEnabled: false,
      ),
    ];

    _accessPermissions = [
      _PermissionItem(
        title: 'Read/Write Records',
        subtitle: 'Ability to create and edit core database records',
        isEnabled: true,
      ),
      _PermissionItem(
        title: 'Bulk Delete Data',
        subtitle: 'Permanent removal of multiple entries in a single action',
        isEnabled: false,
      ),
      _PermissionItem(
        title: 'Export Secure Files',
        subtitle: 'Download PII-protected data as CSV or JSON',
        isEnabled: true,
      ),
      _PermissionItem(
        title: 'Grant Delegate Access',
        subtitle: 'Allow other users to act on behalf of this role',
        isEnabled: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          _buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Template Preset Card
                  _buildPresetCard(),
                  const SizedBox(height: 32),
                  // Permission Sections
                  _buildPermissionSection(
                    'System Admin',
                    Icons.settings,
                    _systemPermissions,
                    (index, val) {
                      setState(() {
                        _systemPermissions[index].isEnabled = val;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  _buildPermissionSection(
                    'Access Control',
                    Icons.security,
                    _accessPermissions,
                    (index, val) {
                      setState(() {
                        _accessPermissions[index].isEnabled = val;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Footer Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info, color: Colors.grey),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Audit Compliance Note',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'This role configuration exceeds the standard "Least Privilege" security model. It is currently under periodic review. Changes to "API Management" and "Bulk Delete" will trigger an alert to the Lead Security Officer.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalRoleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECT ROLE TO CONFIGURE',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _roles.map((role) {
              final isSelected = role == _selectedRole;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () => setState(() => _selectedRole = role),
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE0F2FE)
                          : Colors.white, // Light blue vs white
                      border: Border.all(
                        color: isSelected ? Colors.blue : AppColors.border,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.verified_user
                              : Icons.shield_outlined,
                          size: 16,
                          color: isSelected
                              ? Colors.blue
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          role,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.blue[900]
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPresetCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.auto_fix_high, color: Colors.blueGrey),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apply Template Preset',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  'Quickly reset all toggles to a predefined baseline',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Dropdown Mock
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Text('Full Admin (Preset)', style: TextStyle(fontSize: 13)),
                SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down, size: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Apply',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSection(
    String title,
    IconData icon,
    List<_PermissionItem> items,
    Function(int index, bool newValue) onToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue[800]),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _buildPermissionRow(item, (val) => onToggle(index, val)),
                  if (index != items.length - 1)
                    const Divider(height: 1, indent: 24, endIndent: 24),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionRow(
    _PermissionItem item,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    if (item.isBadged) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Critical',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[900],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: item.isEnabled,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF2563EB),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[200],
              trackOutlineColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$_selectedRole Permissions',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'ACTIVE ROLE',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.history,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                            children: [
                              const TextSpan(text: 'Last modified by '),
                              TextSpan(
                                text: 'admin_01',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: ' on Oct 24, 2023 at 14:32'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Discard Changes'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save Configuration'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildHorizontalRoleSelector(),
        ],
      ),
    );
  }
}

class _PermissionItem {
  final String title;
  final String subtitle;
  bool isEnabled; // Mutable
  final bool isBadged;

  _PermissionItem({
    required this.title,
    required this.subtitle,
    required this.isEnabled,
    this.isBadged = false,
  });
}
