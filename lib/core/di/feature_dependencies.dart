import '../../features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import '../../features/global_search/presentation/bloc/global_search_bloc.dart';
import '../di/injection_container.dart';

// Note: Additional BLoCs (Login, Signup, Organization, Project) will be added here
// as we confirm their locations and refactor them.

import '../../features/auth/bloc/login_bloc/login_bloc.dart';
import '../../features/auth/bloc/signup_bloc/signup_bloc.dart';
import '../../features/projects/presentation/bloc/projects_bloc.dart';

void registerFeatureDependencies() {
  // Global Search
  sl.registerFactory<GlobalSearchBloc>(() => GlobalSearchBloc());

  // Dashboard
  sl.registerFactory<DashboardBloc>(() => DashboardBloc());

  // Auth
  sl.registerFactory<LoginBloc>(() => LoginBloc());
  sl.registerFactory<SignupBloc>(() => SignupBloc());

  // Projects
  sl.registerFactory<ProjectsBloc>(() => ProjectsBloc());
}
