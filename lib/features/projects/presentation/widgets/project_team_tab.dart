import 'package:flutter/material.dart';
import '../../../../src/src.dart';
import '../../../members/presentation/widgets/invite_member_sheet.dart';

class ProjectTeamTab extends StatelessWidget {
  const ProjectTeamTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Active Team',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '12 Members',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Filter by role...',
                        prefixIcon: const Icon(Icons.filter_list, size: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      InviteMemberSheet.show(context);
                    },
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('Add Member'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Member List
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildTableHeader(),
                const Divider(height: 1),
                const _TeamMemberRow(
                  name: 'Alex Rivera',
                  role: 'Project Lead',
                  email: 'alex.rivera@workhub.io',
                  avatarUrl:
                      'https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg',
                  specialization: 'Lead Solutions Architect',
                  joined: 'Jan 02, 2024',
                  tags: ['Lead'],
                  tagColor: Colors.blue,
                ),
                const Divider(height: 1),
                const _TeamMemberRow(
                  name: 'Sarah Chen',
                  role: 'UI/UX Designer',
                  email: 'sarah.c@workhub.io',
                  avatarUrl:
                      'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
                  specialization: 'UI/UX Designer',
                  joined: 'Jan 12, 2024',
                  tags: ['Design'],
                  tagColor: Colors.purple,
                ),
                const Divider(height: 1),
                const _TeamMemberRow(
                  name: 'Marcus Johnson',
                  role: 'Sr. Backend Dev',
                  email: 'm.johnson@workhub.io',
                  avatarUrl:
                      'https://img.freepik.com/free-photo/confident-business-woman-portrait-smiling-face_53876-137693.jpg', // Placeholder
                  specialization: 'Sr. Backend Dev',
                  joined: 'Jan 15, 2024',
                  tags: ['Backend'],
                  tagColor: Colors.green,
                ),
                const Divider(height: 1),
                const _TeamMemberRow(
                  name: 'Elena Rodriguez',
                  role: 'QA Engineer',
                  email: 'e.rodriguez@workhub.io',
                  avatarUrl:
                      'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg', // Placeholder
                  specialization: 'QA Engineer',
                  joined: 'Jan 22, 2024',
                  tags: ['QA'],
                  tagColor: Colors.orange,
                ),
                const Divider(height: 1),
                const _TeamMemberRow(
                  name: 'David Kim',
                  role: 'DevOps Lead',
                  email: 'dkim@workhub.io',
                  avatarUrl:
                      'https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg', // Placeholder
                  specialization: 'DevOps Lead',
                  joined: 'Feb 03, 2024',
                  tags: ['DevOps'],
                  tagColor: Colors.red,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Showing 5 of 12 team members',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () {}, child: const Text('Next')),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Stats Cards
          const Row(
            children: [
              Expanded(
                child: _TeamStatCard(
                  icon: Icons.hub,
                  title: 'Active Collaboration',
                  value: '84%',
                  sub: 'SYNC SCORE',
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _TeamStatCard(
                  icon: Icons.check_circle,
                  title: 'Capacity Used',
                  value: '112 / 160 hrs',
                  sub: 'CURRENT WEEK',
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _TeamStatCard(
                  icon: Icons.history,
                  title: 'Avg. Seniority',
                  value: '4.2 years',
                  sub: 'EXPERIENCE LEVEL',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: Colors.grey[50],
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'NAME & ROLE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'SPECIALIZATION',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'DATE JOINED',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ACTIONS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  final String name;
  final String role;
  final String email;
  final String avatarUrl;
  final String specialization;
  final String joined;
  final List<String> tags;
  final Color tagColor;

  const _TeamMemberRow({
    required this.name,
    required this.role,
    required this.email,
    required this.avatarUrl,
    required this.specialization,
    required this.joined,
    required this.tags,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: tagColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tags.first,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: tagColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  specialization,
                  style: TextStyle(
                    color: tagColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              joined,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.more_vert, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String sub;
  final Color color;

  const _TeamStatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.sub,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      sub,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
