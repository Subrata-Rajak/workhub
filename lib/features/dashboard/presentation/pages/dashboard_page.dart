import 'package:flutter/material.dart';
import '../../../../core/layout/desktop_layout_helper.dart';
import '../widgets/dashboard_sidebar.dart';
import '../widgets/dashboard_topbar.dart';

import '../../../members/presentation/pages/members_page.dart';
import '../widgets/admin_dashboard_content.dart';
import '../widgets/employee_dashboard_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // In a real app, this would be managed by BLoC and Routing
  String _currentView = 'admin'; // Default to admin dashboard

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => DashboardBloc()..add(LoadDashboardData()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final size = DesktopLayoutHelper.getSize(constraints.maxWidth);
            final showSidebar = DesktopLayoutHelper.shouldShowSidePanel(size);

            return Row(
              children: [
                // Persistent Sidebar
                if (showSidebar)
                  DashboardSidebar(
                    onDashboardTap: () =>
                        setState(() => _currentView = 'admin'),
                    onMembersTap: () =>
                        setState(() => _currentView = 'members'),
                    onSettingsTap: () =>
                        setState(() => _currentView = 'employee'),
                    currentView: _currentView,
                  ),

                // Main Content Area
                Expanded(
                  child: Column(
                    children: [
                      const DashboardTopbar(),
                      Expanded(child: _buildContent()),
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

  Widget _buildContent() {
    if (_currentView == 'members') {
      return const MembersPage();
    }
    if (_currentView == 'employee') {
      return const EmployeeDashboardContent();
    }
    // Default to Admin Dashboard
    return const AdminDashboardContent();
  }
}
