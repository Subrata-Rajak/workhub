part of 'global_search_bloc.dart';

/// State for the global search feature
class GlobalSearchState {
  final String query;
  final List<SearchResult> results;
  final bool isLoading;
  final int selectedIndex;

  const GlobalSearchState({
    this.query = '',
    this.results = const [],
    this.isLoading = false,
    this.selectedIndex = -1,
  });

  /// Get results grouped by category
  Map<SearchCategory, List<SearchResult>> get groupedResults {
    final Map<SearchCategory, List<SearchResult>> grouped = {};

    for (final result in results) {
      if (!grouped.containsKey(result.category)) {
        grouped[result.category] = [];
      }
      grouped[result.category]!.add(result);
    }

    return grouped;
  }

  /// Check if there are any results
  bool get hasResults => results.isNotEmpty;

  /// Get the currently selected result (if any)
  SearchResult? get selectedResult {
    if (selectedIndex >= 0 && selectedIndex < results.length) {
      return results[selectedIndex];
    }
    return null;
  }

  GlobalSearchState copyWith({
    String? query,
    List<SearchResult>? results,
    bool? isLoading,
    int? selectedIndex,
  }) {
    return GlobalSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
