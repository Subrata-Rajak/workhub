import 'package:flutter/material.dart';
import 'package:workhub/src/src.dart';
import 'package:workhub/features/global_search/data/models/search_result.dart';
import 'search_result_item.dart';

/// Widget for displaying a category section with its results
class SearchCategorySection extends StatelessWidget {
  final SearchCategory category;
  final List<SearchResult> results;
  final int selectedIndex;
  final int startIndex;
  final Map<int, GlobalKey> resultKeys;
  final ValueChanged<SearchResult> onResultTap;

  const SearchCategorySection({
    super.key,
    required this.category,
    required this.results,
    required this.selectedIndex,
    required this.startIndex,
    required this.resultKeys,
    required this.onResultTap,
  });

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(category.icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                category.displayName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: results.asMap().entries.map((entry) {
              final index = entry.key;
              final result = entry.value;
              final globalIndex = startIndex + index;

              return Container(
                key: resultKeys[globalIndex],
                child: SearchResultItem(
                  result: result,
                  isSelected: globalIndex == selectedIndex,
                  onTap: () => onResultTap(result),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
