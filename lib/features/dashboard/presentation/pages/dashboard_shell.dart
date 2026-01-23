import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/desktop_layout_helper.dart';
import '../../../../core/routing/route_paths.dart';
import '../widgets/dashboard_sidebar.dart';
import '../widgets/dashboard_topbar.dart';
import '../../../global_search/presentation/widgets/global_search_modal.dart';

class DashboardShell extends StatefulWidget {
  final Widget child;

  const DashboardShell({super.key, required this.child});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  bool _isSidebarOpen = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  String _getCurrentView(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(RoutePaths.projects)) return 'projects';
    if (location.startsWith(RoutePaths.members)) return 'members';
    if (location.startsWith(RoutePaths.roles)) return 'roles';
    // Add logic for members/settings if routes exist
    if (location == RoutePaths.dashboard) return 'admin';
    return 'admin';
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final isControlPressed = HardwareKeyboard.instance.isControlPressed;
          final isMetaPressed = HardwareKeyboard.instance.isMetaPressed;

          // Toggle Sidebar: Ctrl/Cmd + B
          if ((isControlPressed || isMetaPressed) &&
              event.logicalKey == LogicalKeyboardKey.keyB) {
            _toggleSidebar();
            return KeyEventResult.handled;
          }

          // Global Search: Ctrl/Cmd + K
          if ((isControlPressed || isMetaPressed) &&
              event.logicalKey == LogicalKeyboardKey.keyK) {
            showGlobalSearchModal(context);
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final size = DesktopLayoutHelper.getSize(constraints.maxWidth);
            final shouldShowSidebar = DesktopLayoutHelper.shouldShowSidePanel(
              size,
            );
            final currentView = _getCurrentView(context);

            return Row(
              children: [
                // Persistent Sidebar
                if (shouldShowSidebar && _isSidebarOpen)
                  DashboardSidebar(
                    currentView: currentView,
                    onDashboardTap: () => context.go(RoutePaths.dashboard),
                    onMembersTap: () => context.go(RoutePaths.members),
                    onProjectsTap: () => context.go(RoutePaths.projects),
                    onRolesTap: () => context.go(RoutePaths.roles),
                    onSettingsTap: () {}, // TODO: Add Settings Route
                    onClose: _toggleSidebar,
                  ),

                // Main Content Area
                Expanded(
                  child: Column(
                    children: [
                      DashboardTopbar(
                        onMenuTap: _toggleSidebar,
                        showMenuIcon: shouldShowSidebar && !_isSidebarOpen,
                      ),

                      // Child Route Content
                      Expanded(child: widget.child),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
