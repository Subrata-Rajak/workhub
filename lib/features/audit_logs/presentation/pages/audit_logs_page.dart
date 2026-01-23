import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class AuditLogsPage extends StatelessWidget {
  const AuditLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 24),

            // Filters
            _buildFilters(),
            const SizedBox(height: 24),

            // Data Table
            _buildDataTable(),

            const SizedBox(height: 24),
            // Pagination
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'System Logs',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            const Text(
              'Audit Logs',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'System Audit Logs',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Review and monitor security events and administrative actions across the organization.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text('Export Report'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB), // Blue
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Config Alerts'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterDropdown(
              'DATE RANGE',
              'Last 30 Days',
              Icons.calendar_today,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildFilterDropdown('ACTION TYPE', 'All Actions', null),
          ),
          const SizedBox(width: 16),
          Expanded(child: _buildFilterDropdown('USER', 'All Users', null)),
          const SizedBox(width: 16),
          // Reset Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Reset Filters',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, IconData? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF9FAFB),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                _buildHeaderCell('', flex: 1), // Arrow place
                _buildHeaderCell('TIMESTAMP', flex: 3),
                _buildHeaderCell('USER', flex: 4), // Bigger for avatar+name
                _buildHeaderCell('ACTION', flex: 3),
                _buildHeaderCell('TARGET', flex: 4),
                _buildHeaderCell('IP ADDRESS', flex: 3),
                _buildHeaderCell(
                  'STATUS',
                  flex: 2,
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          // Rows
          _buildLogRow(
            date: 'Jan 12, 2024',
            time: '14:32:01',
            user: 'Alex Rivera',
            userInitials: 'AR',
            userColor: Colors.blue,
            action: 'Update Role',
            actionColor: Colors.blue,
            targetLabel: 'User:',
            targetValue: 'm_chen@acme.com',
            ip: '192.168.1.144',
            status: 'Success',
            statusColor: Colors.green,
          ),
          _buildLogRow(
            date: 'Jan 12, 2024',
            time: '12:05:44',
            user: 'System Automations',
            userInitials: 'SYS',
            userColor: Colors.grey,
            action: 'Compliance Check',
            actionColor: Colors.purple,
            targetLabel: 'Scope:',
            targetValue: 'Global Security Policy',
            ip: '-- internal --',
            status: 'Success',
            statusColor: Colors.green,
          ),
          _buildLogRow(
            date: 'Jan 12, 2024',
            time: '09:12:12',
            user: 'Sarah Jenkins',
            userInitials: 'SJ',
            userColor: Colors.orange,
            action: 'Access Revoke',
            actionColor: Colors.orange,
            targetLabel: 'Resource:',
            targetValue: 'Production S3 Bucket',
            ip: '45.22.110.12',
            status: 'Failed',
            statusColor: Colors.red,
          ),
          _buildLogRow(
            date: 'Jan 11, 2024',
            time: '23:58:01',
            user: 'System Automations',
            userInitials: 'SYS',
            userColor: Colors.grey,
            action: 'Login Success',
            actionColor: Colors.teal,
            targetLabel: 'Account:',
            targetValue: 'bot_deployer_v4',
            ip: '10.0.4.12',
            status: 'Success',
            statusColor: Colors.green,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(
    String text, {
    required int flex,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildLogRow({
    required String date,
    required String time,
    required String user,
    required String userInitials,
    required Color userColor,
    required String action,
    required Color actionColor,
    required String targetLabel,
    required String targetValue,
    required String ip,
    required String status,
    required Color statusColor,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: userColor,
                      child: Text(
                        userInitials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        user,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: actionColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      action.replaceFirst(
                        ' ',
                        '\n',
                      ), // Hack to wrap like design
                      style: TextStyle(
                        color: actionColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      targetLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      targetValue,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  ip,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: AppColors.border),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing 1 to 10 of 1,248 results',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        Row(
          children: [
            _buildPageButton('Previous', isOutlined: true),
            const SizedBox(width: 8),
            _buildPageNumber('1', isActive: false),
            const SizedBox(width: 4),
            _buildPageNumber('2', isActive: true),
            const SizedBox(width: 4),
            _buildPageNumber('3', isActive: false),
            const SizedBox(width: 4),
            const Text('...', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(width: 4),
            _buildPageNumber('125', isActive: false),
            const SizedBox(width: 8),
            _buildPageButton('Next', isOutlined: true),
          ],
        ),
      ],
    );
  }

  Widget _buildPageButton(String text, {bool isOutlined = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
    );
  }

  Widget _buildPageNumber(String text, {required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2563EB) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: isActive ? null : Border.all(color: AppColors.border),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
