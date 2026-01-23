part of 'global_search_bloc.dart';

/// Base class for all global search events
abstract class GlobalSearchEvent {
  const GlobalSearchEvent();
}

/// Event triggered when the search query changes
class SearchQueryChanged extends GlobalSearchEvent {
  final String query;

  const SearchQueryChanged(this.query);
}

/// Event triggered when a search result is selected
class SearchResultSelected extends GlobalSearchEvent {
  final SearchResult result;

  const SearchResultSelected(this.result);
}

/// Event triggered to clear the search state
class ClearSearch extends GlobalSearchEvent {
  const ClearSearch();
}

/// Event triggered to navigate through results with keyboard
class NavigateResults extends GlobalSearchEvent {
  final int direction; // -1 for up, 1 for down

  const NavigateResults(this.direction);
}

/// Event triggered when Enter key is pressed
class SelectHighlightedResult extends GlobalSearchEvent {
  const SelectHighlightedResult();
}
