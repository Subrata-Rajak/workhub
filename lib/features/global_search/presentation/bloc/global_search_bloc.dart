import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/search_result.dart';

part 'global_search_event.dart';
part 'global_search_state.dart';

/// BLoC for managing global search functionality
class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  GlobalSearchBloc() : super(const GlobalSearchState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchResultSelected>(_onSearchResultSelected);
    on<ClearSearch>(_onClearSearch);
    on<NavigateResults>(_onNavigateResults);
    on<SelectHighlightedResult>(_onSelectHighlightedResult);
  }

  /// Mock data for search results
  static final List<SearchResult> _mockData = [
    // Users
    const SearchResult(
      id: 'u1',
      title: 'Alex Rivera',
      subtitle: 'User · Engineering',
      category: SearchCategory.users,
      icon: Icons.person,
    ),
    const SearchResult(
      id: 'u2',
      title: 'Sarah Jenkins',
      subtitle: 'User · Security',
      category: SearchCategory.users,
      icon: Icons.person,
    ),
    const SearchResult(
      id: 'u3',
      title: 'James Wilson',
      subtitle: 'User · Admin Manager',
      category: SearchCategory.users,
      icon: Icons.person,
    ),
    const SearchResult(
      id: 'u4',
      title: 'Lila Chen',
      subtitle: 'User · Reports',
      category: SearchCategory.users,
      icon: Icons.person,
    ),

    // Projects
    const SearchResult(
      id: 'p1',
      title: 'Website Redesign',
      subtitle: 'Project · Active',
      category: SearchCategory.projects,
      icon: Icons.folder,
    ),
    const SearchResult(
      id: 'p2',
      title: 'Mobile App Beta',
      subtitle: 'Project · Active',
      category: SearchCategory.projects,
      icon: Icons.folder,
    ),
    const SearchResult(
      id: 'p3',
      title: 'Q4 Marketing',
      subtitle: 'Project · Archived',
      category: SearchCategory.projects,
      icon: Icons.folder,
    ),
    const SearchResult(
      id: 'p4',
      title: 'Internal Tools',
      subtitle: 'Project · Active',
      category: SearchCategory.projects,
      icon: Icons.folder,
    ),

    // Settings
    const SearchResult(
      id: 's1',
      title: 'Organization Settings',
      subtitle: 'Settings · General',
      category: SearchCategory.settings,
      icon: Icons.settings,
    ),
    const SearchResult(
      id: 's2',
      title: 'Security Policy',
      subtitle: 'Settings · Security',
      category: SearchCategory.settings,
      icon: Icons.security,
    ),
    const SearchResult(
      id: 's3',
      title: 'User Permissions',
      subtitle: 'Settings · Access Control',
      category: SearchCategory.settings,
      icon: Icons.admin_panel_settings,
    ),
    const SearchResult(
      id: 's4',
      title: 'Billing',
      subtitle: 'Settings · Subscription',
      category: SearchCategory.settings,
      icon: Icons.payment,
    ),

    // Members
    const SearchResult(
      id: 'm1',
      title: 'Engineering Team',
      subtitle: 'Members · 24 people',
      category: SearchCategory.members,
      icon: Icons.groups,
    ),
    const SearchResult(
      id: 'm2',
      title: 'Design Team',
      subtitle: 'Members · 8 people',
      category: SearchCategory.members,
      icon: Icons.groups,
    ),
    const SearchResult(
      id: 'm3',
      title: 'Marketing Team',
      subtitle: 'Members · 12 people',
      category: SearchCategory.members,
      icon: Icons.groups,
    ),
  ];

  /// Handle search query changes
  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<GlobalSearchState> emit,
  ) {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(state.copyWith(query: query, results: [], selectedIndex: -1));
      return;
    }

    // Filter mock data based on query
    final filteredResults = _mockData.where((result) {
      final titleMatch = result.title.toLowerCase().contains(
        query.toLowerCase(),
      );
      final subtitleMatch = result.subtitle.toLowerCase().contains(
        query.toLowerCase(),
      );
      return titleMatch || subtitleMatch;
    }).toList();

    emit(
      state.copyWith(
        query: query,
        results: filteredResults,
        selectedIndex: filteredResults.isNotEmpty ? 0 : -1,
      ),
    );
  }

  /// Handle search result selection
  void _onSearchResultSelected(
    SearchResultSelected event,
    Emitter<GlobalSearchState> emit,
  ) {
    // Log the selection (placeholder for actual navigation/action)
    debugPrint(
      'Selected: ${event.result.title} (${event.result.category.displayName})',
    );

    // In a real app, this would trigger navigation or other actions
    // For now, we just log it
  }

  /// Handle clearing search
  void _onClearSearch(ClearSearch event, Emitter<GlobalSearchState> emit) {
    emit(const GlobalSearchState());
  }

  /// Handle keyboard navigation through results
  void _onNavigateResults(
    NavigateResults event,
    Emitter<GlobalSearchState> emit,
  ) {
    if (state.results.isEmpty) return;

    int newIndex = state.selectedIndex + event.direction;

    // Wrap around at boundaries
    if (newIndex < 0) {
      newIndex = state.results.length - 1;
    } else if (newIndex >= state.results.length) {
      newIndex = 0;
    }

    emit(state.copyWith(selectedIndex: newIndex));
  }

  /// Handle selecting the currently highlighted result
  void _onSelectHighlightedResult(
    SelectHighlightedResult event,
    Emitter<GlobalSearchState> emit,
  ) {
    final selectedResult = state.selectedResult;
    if (selectedResult != null) {
      add(SearchResultSelected(selectedResult));
    }
  }
}
