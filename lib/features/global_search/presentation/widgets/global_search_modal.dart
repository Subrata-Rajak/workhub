import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src/src.dart';
import '../../data/models/search_result.dart';
import '../bloc/global_search_bloc.dart';
import 'search_category_section.dart';
import '../../../../core/di/injection_container.dart';

/// Global search modal dialog
class GlobalSearchModal extends StatefulWidget {
  const GlobalSearchModal({super.key});

  @override
  State<GlobalSearchModal> createState() => _GlobalSearchModalState();
}

class _GlobalSearchModalState extends State<GlobalSearchModal> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late final ScrollController _scrollController;
  final Map<int, GlobalKey> _resultKeys = {};

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _scrollController = ScrollController();

    // Auto-focus the search input when modal opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll to the selected item when navigating with keyboard
  void _scrollToSelected(int selectedIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedKey = _resultKeys[selectedIndex];
      if (selectedKey?.currentContext != null) {
        Scrollable.ensureVisible(
          selectedKey!.currentContext!,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: 0.5, // Center the item
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GlobalSearchBloc>(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
              builder: (context, state) {
                return Focus(
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent) {
                      final bloc = context.read<GlobalSearchBloc>();
                      final currentState = bloc.state;

                      // Handle arrow keys
                      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                        bloc.add(const NavigateResults(1));
                        // Calculate new index for scrolling
                        final newIndex = currentState.selectedIndex + 1;
                        final maxIndex = currentState.results.length - 1;
                        _scrollToSelected(newIndex > maxIndex ? 0 : newIndex);
                        return KeyEventResult.handled;
                      } else if (event.logicalKey ==
                          LogicalKeyboardKey.arrowUp) {
                        bloc.add(const NavigateResults(-1));
                        // Calculate new index for scrolling
                        final newIndex = currentState.selectedIndex - 1;
                        final maxIndex = currentState.results.length - 1;
                        _scrollToSelected(newIndex < 0 ? maxIndex : newIndex);
                        return KeyEventResult.handled;
                      }
                      // Handle Enter key
                      else if (event.logicalKey == LogicalKeyboardKey.enter) {
                        bloc.add(const SelectHighlightedResult());
                        Navigator.of(context).pop();
                        return KeyEventResult.handled;
                      }
                      // Handle Escape key
                      else if (event.logicalKey == LogicalKeyboardKey.escape) {
                        Navigator.of(context).pop();
                        return KeyEventResult.handled;
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 8,
                    shadowColor: Colors.black.withAlpha(50),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 500),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Search Input
                          _buildSearchInput(context, state),

                          const Divider(height: 1),

                          // Search Results
                          Flexible(child: _buildSearchResults(context, state)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInput(BuildContext context, GlobalSearchState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        onChanged: (query) {
          context.read<GlobalSearchBloc>().add(SearchQueryChanged(query));
        },
        decoration: InputDecoration(
          hintText: AppStrings.globalSearchPlaceholder,
          hintStyle: TextStyle(
            color: AppColors.textMuted.withAlpha(200),
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textMuted,
            size: 20,
          ),
          suffixIcon: state.query.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textMuted,
                    size: 18,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    context.read<GlobalSearchBloc>().add(const ClearSearch());
                    _searchFocusNode.requestFocus();
                  },
                )
              : Container(
                  width: 40,
                  height: 20,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Center(
                    child: Text(
                      'ESC',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, GlobalSearchState state) {
    // Empty state - no query
    if (state.query.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 48,
                color: AppColors.textMuted.withAlpha(100),
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.globalSearchEmptyState,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary.withAlpha(200),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // No results found
    if (!state.hasResults) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: AppColors.textMuted.withAlpha(100),
              ),
              const SizedBox(height: 16),
              const Text(
                AppStrings.globalSearchNoResults,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Try different keywords',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Display grouped results
    final groupedResults = state.groupedResults;
    int currentIndex = 0;

    // Clear and rebuild result keys
    _resultKeys.clear();
    for (int i = 0; i < state.results.length; i++) {
      _resultKeys[i] = GlobalKey();
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: SearchCategory.values.map((category) {
          final results = groupedResults[category] ?? [];
          if (results.isEmpty) return const SizedBox.shrink();

          final startIndex = currentIndex;
          currentIndex += results.length;

          return SearchCategorySection(
            category: category,
            results: results,
            selectedIndex: state.selectedIndex,
            startIndex: startIndex,
            resultKeys: _resultKeys,
            onResultTap: (result) {
              context.read<GlobalSearchBloc>().add(
                SearchResultSelected(result),
              );
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}

/// Function to show the global search modal
void showGlobalSearchModal(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Search',
    barrierColor: Colors.black.withAlpha(128),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const GlobalSearchModal();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<double>(begin: 0.95, end: 1.0)),
          child: child,
        ),
      );
    },
  );
}
