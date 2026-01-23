import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../src/src.dart';
import 'create_task_modal.dart';

class TaskModel {
  final String id;
  final String title;
  final String priority;
  final int? subtasks;
  final Color assigneeColor;
  final String assigneeInitial;
  final Color? assignee2Color;
  final String? assignee2Initial;
  final bool isActive;

  TaskModel({
    required this.id,
    required this.title,
    required this.priority,
    this.subtasks,
    required this.assigneeColor,
    required this.assigneeInitial,
    this.assignee2Color,
    this.assignee2Initial,
    this.isActive = false,
  });
}

class ColumnModel {
  final String id;
  final String title;
  final List<TaskModel> tasks;

  ColumnModel({required this.id, required this.title, required this.tasks});
}

class TaskBoardView extends StatefulWidget {
  const TaskBoardView({super.key});

  @override
  State<TaskBoardView> createState() => _TaskBoardViewState();
}

class _TaskBoardViewState extends State<TaskBoardView> {
  late List<ColumnModel> _columns;
  String? _editingColumnId;

  @override
  void initState() {
    super.initState();
    _columns = [
      ColumnModel(
        id: 'backlog',
        title: 'BACKLOG',
        tasks: [
          TaskModel(
            id: 'WH-1024',
            title: 'Migrate legacy MongoDB clusters to AWS DocumentDB',
            priority: 'HIGH',
            subtasks: 3,
            assigneeColor: Colors.purple,
            assigneeInitial: 'A',
          ),
          TaskModel(
            id: 'WH-1031',
            title: 'Internal API Documentation Audit',
            priority: 'LOW',
            assigneeColor: Colors.teal,
            assigneeInitial: 'K',
          ),
        ],
      ),
      ColumnModel(
        id: 'todo',
        title: 'TO DO',
        tasks: [
          TaskModel(
            id: 'WH-1045',
            title: 'Security patch for OpenSSL vulnerability (CVE-2023)',
            priority: 'CRITICAL',
            assigneeColor: Colors.orange,
            assigneeInitial: 'M',
          ),
        ],
      ),
      ColumnModel(
        id: 'in_progress',
        title: 'IN PROGRESS',
        tasks: [
          TaskModel(
            id: 'WH-0988',
            title: 'Optimize CI/CD pipelines for Kubernetes deployment',
            priority: 'MEDIUM',
            subtasks: 5,
            assigneeColor: Colors.blueAccent,
            assigneeInitial: 'R',
            isActive: true,
          ),
        ],
      ),
      ColumnModel(
        id: 'in_review',
        title: 'IN REVIEW',
        tasks: [
          TaskModel(
            id: 'WH-1102',
            title: 'Refactor Authentication Service logging',
            priority: 'MEDIUM',
            assigneeColor: Colors.redAccent,
            assigneeInitial: 'S',
            assignee2Color: Colors.black,
            assignee2Initial: 'J',
          ),
        ],
      ),
      ColumnModel(
        id: 'qa',
        title: 'QA',
        tasks: [
          TaskModel(
            id: 'WH-1055',
            title: 'Load Testing for Payment Gateway Integration',
            priority: 'HIGH',
            assigneeColor: Colors.indigo,
            assigneeInitial: 'D',
          ),
        ],
      ),
    ];
  }

  void _moveTask(String taskId, String sourceColumnId, String targetColumnId) {
    if (sourceColumnId == targetColumnId) return;

    setState(() {
      final sourceColumn = _columns.firstWhere((c) => c.id == sourceColumnId);
      final targetColumn = _columns.firstWhere((c) => c.id == targetColumnId);

      final task = sourceColumn.tasks.firstWhere((t) => t.id == taskId);

      sourceColumn.tasks.remove(task);
      targetColumn.tasks.add(task);
    });
  }

  void _addColumn() {
    setState(() {
      final newId = 'custom_${_columns.length + 1}';
      _columns.add(ColumnModel(id: newId, title: 'NEW COLUMN', tasks: []));
    });
  }

  void _deleteColumn(String columnId) {
    final column = _columns.firstWhere((c) => c.id == columnId);

    if (column.tasks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Discard Column?'),
          content: const Text(
            'This column contains tasks. Discarding it will remove all tasks. Are you sure?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _columns.remove(column));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Discard'),
            ),
          ],
        ),
      );
    } else {
      setState(() => _columns.remove(column));
    }
  }

  void _startEditing(String columnId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Edit Column Name'),
        content: const Text(
          'This action will affect all related tasks. Do you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _editingColumnId = columnId);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _updateColumnName(String columnId, String newName) {
    setState(() {
      final index = _columns.indexWhere((c) => c.id == columnId);
      if (index != -1) {
        _columns[index] = ColumnModel(
          id: columnId,
          title: newName,
          tasks: _columns[index].tasks,
        );
      }
      _editingColumnId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._columns.map((column) {
              return _BoardColumn(
                column: column,
                onDrop: (taskId) =>
                    _moveTask(taskId, _findColumnId(taskId), column.id),
                showAddTask: true,
                isEditing: _editingColumnId == column.id,
                onEdit: () => _startEditing(column.id),
                onDelete: () => _deleteColumn(column.id),
                onAddTask: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withAlpha(50),
                    builder: (context) => const CreateTaskModal(),
                  );
                },
                onRename: (newName) => _updateColumnName(column.id, newName),
              );
            }),
            // Add Custom Column Button
            Container(
              width: 300,
              padding: const EdgeInsets.only(top: 2), // Align with headers
              child: OutlinedButton.icon(
                onPressed: _addColumn,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Section', textAlign: TextAlign.center),
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.center,
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(
                    color: AppColors.border,
                    style: BorderStyle.solid,
                  ), // Fixed lint
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _findColumnId(String taskId) {
    for (final col in _columns) {
      if (col.tasks.any((t) => t.id == taskId)) {
        return col.id;
      }
    }
    return '';
  }
}

class _BoardColumn extends StatelessWidget {
  final ColumnModel column;
  final Function(String taskId) onDrop;
  final bool showAddTask;
  final bool isEditing;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAddTask;
  final ValueChanged<String>? onRename;

  const _BoardColumn({
    required this.column,
    required this.onDrop,
    this.showAddTask = false,
    this.isEditing = false,
    this.onEdit,
    this.onDelete,
    this.onAddTask,
    this.onRename,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAccept: (taskId) {
        // Don't accept if already in this column
        return !column.tasks.any((t) => t.id == taskId);
      },
      onAccept: onDrop,
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 300,
          margin: const EdgeInsets.only(right: 16),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          color: Colors.transparent, // Ensure hit test works on empty space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column Header
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    if (isEditing)
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: TextEditingController(text: column.title),
                          onSubmitted: onRename,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      )
                    else ...[
                      Text(
                        column.title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: candidateData.isNotEmpty
                              ? AppColors.primary.withAlpha(20)
                              : AppColors.textSecondary.withAlpha(20),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${column.tasks.length}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: candidateData.isNotEmpty
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    PopupMenuButton<String>(
                      color: Colors.white,
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      onSelected: (value) {
                        if (value == 'edit') {
                          onEdit?.call();
                        } else if (value == 'discard') {
                          onDelete?.call();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit Name'),
                        ),
                        const PopupMenuItem(
                          value: 'discard',
                          child: Text(
                            'Discard',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tasks List
              ...column.tasks.map(
                (task) => Draggable<String>(
                  data: task.id,
                  feedback: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 300,
                      child: _TaskCard(task: task, isDragging: true),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _TaskCard(task: task),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _TaskCard(task: task),
                  ),
                ),
              ),

              // Drop Target Indicator (when dragging over)
              if (candidateData.isNotEmpty)
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(10),
                    border: Border.all(
                      color: AppColors.primary.withAlpha(50),
                      style: BorderStyle.solid,
                    ), // Fixed lint
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Drop here',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              // Add Task Button
              if (showAddTask)
                InkWell(
                  onTap: onAddTask,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary.withAlpha(50),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary.withAlpha(5),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 16, color: AppColors.primary),
                          SizedBox(width: 8),
                          Text(
                            'Add Task',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isDragging;

  const _TaskCard({required this.task, this.isDragging = false});

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'CRITICAL':
        return Colors.red;
      case 'HIGH':
        return Colors.redAccent;
      case 'MEDIUM':
        return Colors.orange;
      case 'LOW':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityBg(String priority) {
    return _getPriorityColor(priority).withAlpha(20);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/tasks/${task.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: task.isActive
              ? Border.all(color: AppColors.primary, width: 2)
              : Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.id,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                if (!task.isActive && !isDragging)
                  const Icon(
                    Icons.drag_indicator,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Priority Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityBg(task.priority),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      if (task.priority == 'CRITICAL') ...[
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 12,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 4),
                      ] else if (task.priority == 'HIGH') ...[
                        const Icon(
                          Icons.arrow_upward,
                          size: 12,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 4),
                      ] else if (task.priority == 'MEDIUM') ...[
                        const Icon(
                          Icons.remove,
                          size: 12,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                      ] else ...[
                        const Icon(
                          Icons.arrow_downward,
                          size: 12,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        task.priority,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getPriorityColor(task.priority),
                        ),
                      ),
                    ],
                  ),
                ),

                if (task.subtasks != null) ...[
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.extension_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${task.subtasks}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],

                const Spacer(),

                // Assignees
                SizedBox(
                  height: 24,
                  width: task.assignee2Initial != null ? 36 : 24,
                  child: Stack(
                    children: [
                      if (task.assignee2Initial != null)
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: task.assignee2Color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              task.assignee2Initial!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: task.assigneeColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            task.assigneeInitial,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
