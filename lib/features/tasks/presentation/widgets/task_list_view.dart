import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../src/src.dart';

// Local model for List View to avoid modifying Board View code
class ListTaskModel {
  final String id;
  final String title;
  final String status;
  final String priority;
  final String assigneeName;
  final String assigneeAvatar; // URL or Initials
  final Color assigneeColor; // For placeholder
  final String dueDate;

  ListTaskModel({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    required this.assigneeName,
    required this.assigneeAvatar,
    required this.assigneeColor,
    required this.dueDate,
  });
}

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late List<ListTaskModel> _tasks;

  @override
  void initState() {
    super.initState();
    // Dummy Data matching the design
    _tasks = [
      ListTaskModel(
        id: 'WH-1024',
        title: 'Migrate legacy MongoDB clusters to AWS DocumentDB',
        status: 'BACKLOG',
        priority: 'HIGH',
        assigneeName: 'Alex Rivera',
        assigneeAvatar: 'AR',
        assigneeColor: Colors.purple,
        dueDate: 'Oct 24, 2023',
      ),
      ListTaskModel(
        id: 'WH-1045',
        title: 'Security patch for OpenSSL vulnerability (CVE-2023)',
        status: 'TO DO',
        priority: 'CRITICAL',
        assigneeName: 'Sarah Chen',
        assigneeAvatar: 'SC',
        assigneeColor: Colors.orange,
        dueDate: 'Oct 20, 2023',
      ),
      ListTaskModel(
        id: 'WH-0988',
        title: 'Optimize CI/CD pipelines for Kubernetes deployment',
        status: 'IN PROGRESS',
        priority: 'MEDIUM',
        assigneeName: 'Marco Rossi',
        assigneeAvatar: 'MR',
        assigneeColor: Colors.blue,
        dueDate: 'Oct 28, 2023',
      ),
      ListTaskModel(
        id: 'WH-1102',
        title: 'Refactor Authentication Service logging',
        status: 'IN REVIEW',
        priority: 'MEDIUM',
        assigneeName: 'Elena Vance',
        assigneeAvatar: 'EV',
        assigneeColor: Colors.black,
        dueDate: 'Nov 02, 2023',
      ),
      ListTaskModel(
        id: 'WH-1056',
        title: 'Load Testing for Payment Gateway Integration',
        status: 'QA',
        priority: 'HIGH',
        assigneeName: 'Jordan Smith',
        assigneeAvatar: 'JS',
        assigneeColor: Colors.green,
        dueDate: 'Oct 19, 2023',
      ),
      ListTaskModel(
        id: 'WH-0941',
        title: 'SSL Certificate Renewal (Wildcard)',
        status: 'DONE',
        priority: 'LOW',
        assigneeName: 'Tariq Ali',
        assigneeAvatar: 'TA',
        assigneeColor: Colors.teal,
        dueDate: 'Oct 15, 2023',
      ),
      ListTaskModel(
        id: 'WH-1031',
        title: 'Internal API Documentation Audit',
        status: 'BACKLOG',
        priority: 'LOW',
        assigneeName: 'Ava Thompson',
        assigneeAvatar: 'AT',
        assigneeColor: Colors.cyan,
        dueDate: 'Nov 10, 2023',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                _buildHeader('KEY', flex: 1),
                _buildHeader('TITLE', flex: 4),
                _buildHeader('STATUS', flex: 1),
                _buildHeader('PRIORITY', flex: 1),
                _buildHeader('ASSIGNEE', flex: 2),
                _buildHeader(
                  'DUE DATE',
                  flex: 1,
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),

          // Table Body
          Expanded(
            child: ListView.separated(
              itemCount: _tasks.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: AppColors.border),
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final isDone = task.status == 'DONE';

                return InkWell(
                  onTap: () {
                    context.push('/tasks/${task.id}');
                  },
                  hoverColor: AppColors.primary.withAlpha(5),
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        // KEY
                        Expanded(
                          flex: 1,
                          child: Text(
                            task.id,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        // TITLE
                        Expanded(
                          flex: 4,
                          child: Text(
                            task.title,
                            style: TextStyle(
                              color: isDone
                                  ? AppColors.textSecondary
                                  : AppColors.textPrimary,
                              fontSize: 13,
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // STATUS
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _StatusBadge(status: task.status),
                          ),
                        ),
                        // PRIORITY
                        Expanded(
                          flex: 1,
                          child: _PriorityIndicator(priority: task.priority),
                        ),
                        // ASSIGNEE
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: task.assigneeColor,
                                child: Text(
                                  task.assigneeAvatar,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                task.assigneeName,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // DUE DATE
                        Expanded(
                          flex: 1,
                          child: Text(
                            task.dueDate,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Pagination Footer
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Text(
                  'TOTAL TASKS: ${_tasks.length}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 24),
                Container(width: 1, height: 16, color: AppColors.border),
                const SizedBox(width: 24),
                const Text(
                  'FILTERS: SPRINT 24',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.chevron_left, size: 20),
                    ),
                    const Text(
                      'Page 1 of 5',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right, size: 20),
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

  Widget _buildHeader(
    String label, {
    required int flex,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: alignment,
        child: Text(
          label,
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
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case 'BACKLOG':
        bg = Colors.grey.withAlpha(50);
        fg = AppColors.textPrimary;
        break;
      case 'TO DO':
        bg = Colors.blueGrey.withAlpha(50);
        fg = AppColors.textPrimary;
        break;
      case 'IN PROGRESS':
        bg = Colors.blue.withAlpha(30);
        fg = Colors.blue.shade900;
        break;
      case 'IN REVIEW':
        bg = Colors.purple.withAlpha(30);
        fg = Colors.purple.shade900;
        break;
      case 'QA':
        bg = Colors.orange.withAlpha(30);
        fg = Colors.orange.shade900;
        break;
      case 'DONE':
        bg = Colors.green.withAlpha(30);
        fg = Colors.green.shade900;
        break;
      default:
        bg = Colors.grey;
        fg = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  final String priority;

  const _PriorityIndicator({required this.priority});

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();

    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          priority,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getColor() {
    switch (priority) {
      case 'CRITICAL':
      case 'HIGH':
        return Colors.red;
      case 'MEDIUM':
        return Colors.orange;
      case 'LOW':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  IconData _getIcon() {
    switch (priority) {
      case 'CRITICAL':
        return Icons.dangerous;
      case 'HIGH':
        return Icons.priority_high;
      case 'MEDIUM':
        return Icons.stacked_bar_chart;
      case 'LOW':
        return Icons.arrow_downward;
      default:
        return Icons.circle;
    }
  }
}
