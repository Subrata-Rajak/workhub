import 'package:flutter/material.dart';

enum ProjectStatus { active, onHold, completed, archived }

class Project {
  final String id;
  final String name;
  final String code; // e.g. WH-204
  final String client;
  final ProjectStatus status;
  final List<String> team; // List of avatar names/initials or image URLs
  final DateTime lastUpdated;

  const Project({
    required this.id,
    required this.name,
    required this.code,
    required this.client,
    required this.status,
    required this.team,
    required this.lastUpdated,
  });

  Color get statusColor {
    switch (status) {
      case ProjectStatus.active:
        return Colors.blue;
      case ProjectStatus.onHold:
        return Colors.orange;
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.archived:
        return Colors.grey;
    }
  }

  String get statusLabel {
    switch (status) {
      case ProjectStatus.active:
        return 'Active';
      case ProjectStatus.onHold:
        return 'On Hold';
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.archived:
        return 'Archived';
    }
  }

  // Dummy data generator
  static List<Project> get dummyData {
    return [
      Project(
        id: '1',
        name: 'Cloud Migration',
        code: 'WH-204',
        client: 'Internal IT',
        status: ProjectStatus.active,
        team: ['A', 'B', 'C', 'D'],
        lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Project(
        id: '2',
        name: 'ERP Integration',
        code: 'WH-112',
        client: 'Finance Dept',
        status: ProjectStatus.onHold,
        team: ['X', 'Y'],
        lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Project(
        id: '3',
        name: 'Security Patching',
        code: 'WH-88',
        client: 'CyberOps',
        status: ProjectStatus.completed,
        team: ['S'],
        lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Project(
        id: '4',
        name: 'Mobile App Update',
        code: 'WH-405',
        client: 'Marketing',
        status: ProjectStatus.active,
        team: ['M', 'K', 'L', 'O', 'P'],
        lastUpdated: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Project(
        id: '5',
        name: 'Legacy Decommission',
        code: 'WH-09',
        client: 'Operations',
        status: ProjectStatus.archived,
        team: ['Z'],
        lastUpdated: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }
}
