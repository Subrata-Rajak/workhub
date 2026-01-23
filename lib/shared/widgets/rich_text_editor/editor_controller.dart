import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TaskDescriptionEditor {
  final QuillController controller;

  TaskDescriptionEditor() : controller = QuillController.basic();

  void dispose() {
    controller.dispose();
  }

  // Get content as JSON string for storage
  String getJson() {
    final json = jsonEncode(controller.document.toDelta().toJson());
    return json;
  }

  // Check if content is empty
  bool get isEmpty => controller.document.isEmpty();

  // Load content from JSON string
  void loadJson(String json) {
    if (json.isEmpty) return;
    try {
      final List<dynamic> delta = jsonDecode(json);
      controller.document = Document.fromJson(delta);
    } catch (e) {
      debugPrint('Error loading rich text: $e');
    }
  }

  // Clear content
  void clear() {
    controller.clear();
  }
}
