import 'package:flutter/material.dart';

/// Enum representing different search result categories
enum SearchCategory { users, projects, settings, members }

/// Extension to get display name and icon for each category
extension SearchCategoryExtension on SearchCategory {
  String get displayName {
    switch (this) {
      case SearchCategory.users:
        return 'Users';
      case SearchCategory.projects:
        return 'Projects';
      case SearchCategory.settings:
        return 'Settings';
      case SearchCategory.members:
        return 'Members';
    }
  }

  IconData get icon {
    switch (this) {
      case SearchCategory.users:
        return Icons.person_outline;
      case SearchCategory.projects:
        return Icons.folder_outlined;
      case SearchCategory.settings:
        return Icons.settings_outlined;
      case SearchCategory.members:
        return Icons.people_outline;
    }
  }
}

/// Model representing a single search result
class SearchResult {
  final String id;
  final String title;
  final String subtitle;
  final SearchCategory category;
  final IconData icon;

  const SearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResult &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
