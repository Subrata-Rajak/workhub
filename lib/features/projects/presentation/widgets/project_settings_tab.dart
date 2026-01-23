import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class ProjectSettingsTab extends StatelessWidget {
  const ProjectSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // General Information Section
          _buildSectionHeader(
            title: 'General Information',
            description: 'Update your project identity and description.',
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                _buildTextFieldRow(
                  label: 'Project Name',
                  description: 'Displayed in dashboards and reports.',
                  initialValue: 'Cloud Migration 2024',
                ),
                const SizedBox(height: 24),
                _buildTextFieldRow(
                  label: 'Project Key',
                  description: 'Immutable identifier for referencing.',
                  initialValue: 'PRJ-102',
                  readOnly: true,
                  isFilled: true,
                ),
                const SizedBox(height: 24),
                _buildTextFieldRow(
                  label: 'Description',
                  description: 'Provide context for the engineering team.',
                  initialValue:
                      'Migrating core legacy infrastructure to AWS hybrid cloud environment. Includes database restructuring and API gateway implementation.',
                  maxLines: 4,
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          // Danger Zone Section
          Text(
            'Danger Zone',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Irreversible actions that affect project data and availability.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F5), // Light red bg
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.error.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                _buildDangerZoneRow(
                  title: 'Archive this project',
                  description:
                      'Mark the project as read-only and remove from active list.',
                  button: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: BorderSide(color: AppColors.error.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Archive'),
                  ),
                ),
                Divider(height: 1, color: AppColors.error.withOpacity(0.1)),
                _buildDangerZoneRow(
                  title: 'Delete this project',
                  description:
                      'Once deleted, it cannot be recovered. Please be certain.',
                  button: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Delete Permanently'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildTextFieldRow({
    required String label,
    required String description,
    required String initialValue,
    bool readOnly = false,
    bool isFilled = false,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: TextFormField(
            initialValue: initialValue,
            readOnly: readOnly,
            maxLines: maxLines,
            style: TextStyle(
              color: readOnly ? AppColors.textSecondary : AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              filled: isFilled || readOnly,
              fillColor: (isFilled || readOnly)
                  ? const Color(0xFFF3F4F6)
                  : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZoneRow({
    required String title,
    required String description,
    required Widget button,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          button,
        ],
      ),
    );
  }
}
