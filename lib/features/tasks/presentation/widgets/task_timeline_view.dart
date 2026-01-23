import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../src/src.dart';

// Local model for Timeline View
class TimelineTaskModel {
  final String id;
  final String title;
  final String assigneeName;
  final String assigneeAvatar;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;
  final double progress; // 0.0 to 1.0

  TimelineTaskModel({
    required this.id,
    required this.title,
    required this.assigneeName,
    required this.assigneeAvatar,
    required this.startDate,
    required this.endDate,
    required this.color,
    this.progress = 0.0,
  });
}

class TaskTimelineView extends StatefulWidget {
  const TaskTimelineView({super.key});

  @override
  State<TaskTimelineView> createState() => _TaskTimelineViewState();
}

class _TaskTimelineViewState extends State<TaskTimelineView> {
  final ScrollController _verticalController1 = ScrollController();
  final ScrollController _verticalController2 = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  late List<TimelineTaskModel> _tasks;

  // Date range settings
  final DateTime _projectStartDate = DateTime(2023, 8, 14); // Aug 14
  final int _daysToShow = 14;
  final double _dayWidth = 120.0;
  final double _rowHeight = 56.0;
  final double _headerHeight = 50.0;

  // Helper to calculate offset based on date
  double _getDateOffset(DateTime date) {
    final difference = date.difference(_projectStartDate).inDays;
    return difference * _dayWidth;
  }

  // Helper to format date
  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  @override
  void initState() {
    super.initState();

    // Sync scrolling
    _verticalController1.addListener(() {
      if (_verticalController1.offset != _verticalController2.offset) {
        _verticalController2.jumpTo(_verticalController1.offset);
      }
    });
    _verticalController2.addListener(() {
      if (_verticalController2.offset != _verticalController1.offset) {
        _verticalController1.jumpTo(_verticalController2.offset);
      }
    });

    // Dummy Data
    _tasks = [
      TimelineTaskModel(
        id: 'WH-1024',
        title: 'Migrate legacy MongoDB clusters',
        assigneeName: 'Alex Rivera',
        assigneeAvatar: 'AR',
        startDate: DateTime(2023, 8, 15),
        endDate: DateTime(2023, 8, 18), // 3 days
        color: Colors.redAccent,
        progress: 0.6,
      ),
      TimelineTaskModel(
        id: 'WH-1045',
        title: 'Security patch OpenSSL',
        assigneeName: 'Sarah Chen',
        assigneeAvatar: 'SC',
        startDate: DateTime(2023, 8, 17),
        endDate: DateTime(2023, 8, 19),
        color: Colors.orange,
        progress: 0.3,
      ),
      TimelineTaskModel(
        id: 'WH-0988',
        title: 'Optimize CI/CD pipelines',
        assigneeName: 'Marco Rossi',
        assigneeAvatar: 'MR',
        startDate: DateTime(2023, 8, 14),
        endDate: DateTime(2023, 8, 18),
        color: Colors.blueAccent,
        progress: 0.8,
      ),
      TimelineTaskModel(
        id: 'WH-1102',
        title: 'Refactor Auth Service logging',
        assigneeName: 'Elena Vance',
        assigneeAvatar: 'EV',
        startDate: DateTime(2023, 8, 19),
        endDate: DateTime(2023, 8, 22),
        color: Colors.blueGrey,
        progress: 0.0,
      ),
      TimelineTaskModel(
        id: 'WH-1056',
        title: 'Load Testing - Payment Integration',
        assigneeName: 'Jordan Smith',
        assigneeAvatar: 'JS',
        startDate: DateTime(2023, 8, 20),
        endDate: DateTime(2023, 8, 22),
        color: Colors.redAccent.shade100,
        progress: 0.0,
      ),
      TimelineTaskModel(
        id: 'WH-0941',
        title: 'SSL Certificate Renewal',
        assigneeName: 'Tariq Ali',
        assigneeAvatar: 'TA',
        startDate: DateTime(2023, 8, 14),
        endDate: DateTime(2023, 8, 15),
        color: Colors.tealAccent.shade700,
        progress: 1.0,
      ),
    ];
  }

  @override
  void dispose() {
    _verticalController1.dispose();
    _verticalController2.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Control Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_ViewToggle()],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                // LEFT PANEL: Task List
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      // Header
                      Container(
                        height: _headerHeight,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 24),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.border),
                            right: BorderSide(color: AppColors.border),
                          ),
                        ),
                        child: const Text(
                          'TASKS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      // List
                      Expanded(
                        child: ListView.builder(
                          controller: _verticalController1,
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
                            return InkWell(
                              onTap: () => context.push('/tasks/${task.id}'),
                              child: Container(
                                height: _rowHeight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.border,
                                      width: 0.5,
                                    ),
                                    right: BorderSide(color: AppColors.border),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.id,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      task.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // RIGHT PANEL: Timeline Grid
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _horizontalController,
                    child: SizedBox(
                      width: _dayWidth * _daysToShow,
                      child: Column(
                        children: [
                          // Header (Dates)
                          SizedBox(
                            height: _headerHeight,
                            child: Row(
                              children: List.generate(_daysToShow, (index) {
                                final date = _projectStartDate.add(
                                  Duration(days: index),
                                );
                                final isToday =
                                    date.day == 17; // Fake today for demo
                                return Container(
                                  width: _dayWidth,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.border,
                                      ),
                                      right: BorderSide(
                                        color: AppColors.border,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _formatDate(date).toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: isToday
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _getDayName(date),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),

                          // Grid Body
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _verticalController2,
                              physics:
                                  const ClampingScrollPhysics(), // Important for sync
                              child: SizedBox(
                                height: _tasks.length * _rowHeight,
                                child: Stack(
                                  children: [
                                    // Background Grid Lines
                                    Row(
                                      children: List.generate(_daysToShow, (
                                        index,
                                      ) {
                                        return Container(
                                          width: _dayWidth,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: AppColors.border,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),

                                    // Today Line (Demo: Aug 17)
                                    Positioned(
                                      left:
                                          _getDateOffset(
                                            DateTime(2023, 8, 17),
                                          ) +
                                          (_dayWidth / 2),
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 1,
                                        color: AppColors.primary,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Positioned(
                                              top: -4,
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.primary,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Task Bars
                                    for (int i = 0; i < _tasks.length; i++)
                                      _buildTaskBar(i, _tasks[i]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskBar(int index, TimelineTaskModel task) {
    final startOffset = _getDateOffset(task.startDate);
    final width = _getDateOffset(task.endDate) - startOffset;

    return Positioned(
      top: (index * _rowHeight) + (_rowHeight - 32) / 2, // Center vertically
      left: startOffset,
      width: width,
      height: 32,
      child: GestureDetector(
        onTap: () => context.push('/tasks/${task.id}'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4), // Gap between days
          decoration: BoxDecoration(
            color: task.color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (task.assigneeAvatar.isNotEmpty)
                CircleAvatar(
                  radius: 10,
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/100',
                  ), // Placeholder
                  backgroundColor: Colors.white.withAlpha(50),
                  child: task.assigneeAvatar.length < 3
                      ? Text(
                          task.assigneeAvatar,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption('Day', true),
          Container(width: 1, height: 20, color: AppColors.border),
          _buildOption('Week', false),
          Container(width: 1, height: 20, color: AppColors.border),
          _buildOption('Month', false),
        ],
      ),
    );
  }

  Widget _buildOption(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isSelected ? Colors.white : Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
