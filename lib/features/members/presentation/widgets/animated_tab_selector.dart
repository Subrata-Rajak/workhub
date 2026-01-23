import 'package:flutter/material.dart';
import '../../../../src/src.dart';

/// Animated tab selector with sliding indicator
class AnimatedTabSelector extends StatefulWidget {
  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int> onTabSelected;

  const AnimatedTabSelector({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    required this.onTabSelected,
  });

  @override
  State<AnimatedTabSelector> createState() => _AnimatedTabSelectorState();
}

class _AnimatedTabSelectorState extends State<AnimatedTabSelector> {
  late int _selectedIndex;
  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    // Create keys for each tab
    for (int i = 0; i < widget.tabs.length; i++) {
      _tabKeys.add(GlobalKey());
    }
  }

  double _getIndicatorPosition() {
    if (_tabKeys[_selectedIndex].currentContext == null) {
      return 0;
    }

    final RenderBox? renderBox =
        _tabKeys[_selectedIndex].currentContext?.findRenderObject()
            as RenderBox?;

    if (renderBox == null) return 0;

    final position = renderBox.localToGlobal(Offset.zero);
    final containerBox = context.findRenderObject() as RenderBox?;

    if (containerBox == null) return 0;

    final containerPosition = containerBox.localToGlobal(Offset.zero);
    return position.dx - containerPosition.dx;
  }

  double _getIndicatorWidth() {
    if (_tabKeys[_selectedIndex].currentContext == null) {
      return 70; // Default width
    }

    final RenderBox? renderBox =
        _tabKeys[_selectedIndex].currentContext?.findRenderObject()
            as RenderBox?;

    return renderBox?.size.width ?? 70;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate after layout
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() {});
          });

          return Stack(
            children: [
              // Animated sliding indicator
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: _getIndicatorPosition(),
                top: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: _getIndicatorWidth(),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: AppElevation.filterTab,
                  ),
                ),
              ),
              // Tab labels
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.tabs.length, (index) {
                  return GestureDetector(
                    key: _tabKeys[index],
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      widget.onTabSelected(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Text(
                        widget.tabs[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: _selectedIndex == index
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: _selectedIndex == index
                              ? const Color(0xFF1F2937)
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
