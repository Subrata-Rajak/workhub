import 'package:flutter/material.dart';
import '../../../../src/src.dart';
import '../../../../shared/widgets/rich_text_editor/editor_controller.dart';
import '../../../../shared/widgets/rich_text_editor/rich_text_editor.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  bool _showSecondaryFields = false;
  bool _createAnother = false;
  final TaskDescriptionEditor _editor = TaskDescriptionEditor();

  @override
  void dispose() {
    _editor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 800,
        height: 800, // Fixed height or constrained
        constraints: const BoxConstraints(maxHeight: 900),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Create New Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Title
                    _buildLabel('Task Title', isRequired: true),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'e.g., Fix login authentication error',
                        hintStyle: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
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
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),

                    // Row 1: Type & Project
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Task Type',
                            value: 'Standard Task',
                            icon: Icons.edit_note,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Project',
                            isRequired: true,
                            hint: 'Search for a project...',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Row 2: Priority & Assignee
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Priority',
                            value: 'P2 - Medium',
                            colorIndicator: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Assignee',
                            value: 'Felix Henderson',
                            avatar: 'https://i.pravatar.cc/100?u=felix',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Description
                    _buildLabel('Description'),
                    const SizedBox(height: 8),
                    RichTextEditor(
                      editor: _editor,
                      placeholder: 'Add a description for this task...',
                      minHeight: 200,
                    ),
                    const SizedBox(height: 24),

                    // Secondary Fields Toggle
                    InkWell(
                      onTap: () {
                        setState(() {
                          _showSecondaryFields = !_showSecondaryFields;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            _showSecondaryFields
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Show secondary fields (Labels, Sprint, Attachments)',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (_showSecondaryFields) ...[
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Labels'),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.border),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildTag('UI-Kit', Colors.blue),
                                      const SizedBox(width: 8),
                                      _buildTag('Internal', Colors.orange),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '+ Add Label',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildDropdownField(
                              label: 'Sprint',
                              value: 'Sprint 42 (Current)',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Attachments
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.border,
                            style: BorderStyle.solid,
                          ), // Dashed border not native, solid for now
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFAFAFA),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.upload_file,
                              size: 32,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                                children: [
                                  TextSpan(text: 'Drag & drop files or '),
                                  TextSpan(
                                    text: 'browse',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _createAnother,
                    onChanged: (val) => setState(() => _createAnother = val!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Text(
                    'Create and add another',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '+ ENTER TO CREATE',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: Colors.transparent),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle create logic
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Create Task',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(text: text),
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    String? hint,
    IconData? icon,
    Color? colorIndicator,
    String? avatar,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, isRequired: isRequired),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFFAFAFA),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
              ],
              if (colorIndicator != null) ...[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: colorIndicator,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (avatar != null) ...[
                CircleAvatar(backgroundImage: NetworkImage(avatar), radius: 10),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  value ?? hint ?? '',
                  style: TextStyle(
                    color: value != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.close, size: 12, color: color),
        ],
      ),
    );
  }
}
