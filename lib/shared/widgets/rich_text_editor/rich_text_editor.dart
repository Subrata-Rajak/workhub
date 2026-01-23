import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'editor_controller.dart';

class RichTextEditor extends StatelessWidget {
  final TaskDescriptionEditor editor;
  final String? placeholder;
  final double minHeight;

  const RichTextEditor({
    super.key,
    required this.editor,
    this.placeholder,
    this.minHeight = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
              color: Color(0xFFFAFAFA),
            ),
            child: QuillSimpleToolbar(
              controller: editor.controller,
              config: QuillSimpleToolbarConfig(
                showFontFamily: false,
                showFontSize: false,
                showSearchButton: false,
                showIndent: false,
                showSubscript: false,
                showSuperscript: false,
                showColorButton: false,
                showBackgroundColorButton: false,
                showListCheck: false,
                showCodeBlock: true,
                showQuote: false,
                showInlineCode: false,
                showLink: true,
                showUndo: false,
                showRedo: false,
                showDirection: false,
                showAlignmentButtons: false,
                showHeaderStyle: false,
                multiRowsDisplay: false,
                showUnderLineButton: true,
                showStrikeThrough: true,
                showClearFormat: true,

                // Creating a compact toolbar
                toolbarSectionSpacing: 0,
                toolbarIconAlignment: WrapAlignment.spaceBetween,
                buttonOptions: QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                    iconSize: 12, // Smaller icons
                    iconTheme: QuillIconTheme(
                      iconButtonSelectedData: IconButtonData(
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(28, 28),
                        ),
                      ),
                      iconButtonUnselectedData: IconButtonData(
                        style: IconButton.styleFrom(
                          foregroundColor: const Color(0xFF757575),
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(28, 28),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Editor Area
          Container(
            constraints: BoxConstraints(minHeight: minHeight),
            padding: const EdgeInsets.all(16),
            child: QuillEditor.basic(
              controller: editor.controller,
              config: QuillEditorConfig(placeholder: placeholder),
            ),
          ),
        ],
      ),
    );
  }
}
