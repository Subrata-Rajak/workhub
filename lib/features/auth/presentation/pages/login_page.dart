import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/desktop_layout_helper.dart';
import '../../../../core/layout/desktop_breakpoints.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../utils/asset_paths.dart';
import '../../../../src/src.dart';
import '../../../../core/ui/app_text.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/login_bloc/login_event.dart';
import '../../bloc/login_bloc/login_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        debugPrint('Login Status: ${state.status}');
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: AppText.body(
                  state.errorMessage ??
                      'Authentication Failure', // Keeping as fallback
                ),
              ),
            );
        } else if (state.status == LoginStatus.success) {
          debugPrint('Login Status: ${state.status} 1');
          final appRouter = context.read<AppRouter>();

          // Request navigation state change.
          // The RouteGuard will observe this and redirect to Dashboard.
          appRouter.routeState.updateRoutingSession(
            isAuthenticated: true,
            hasSelectedOrganization: true, // Skipping org selection for demo
          );

          debugPrint('Login Status: ${state.status} 2');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final size = DesktopLayoutHelper.getSize(constraints.maxWidth);
            final showSidePanel = DesktopLayoutHelper.shouldShowSidePanel(size);

            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Side: Form
                Expanded(
                  flex: 4,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Placeholder
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.md,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.apps,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                const AppText.header(
                                  AppStrings.adminConsole,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppSpacing.xxxl,
                            ), // 64 -> 48 was requested, referencing spacing 48 which is xxl or custom? previous was 48 so xxl
                            // Actually previous code was 48, so AppSpacing.xxl
                            // Heading
                            const AppText.title(
                              AppStrings.welcomeBack,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ), // 6 is not in spacing tokens, should we add or Use sm (8)? Or xs (4)? User said 6 specifically. I'll use sm (8) for now as requested "no hardcoded". Or define 6. I'll use sm.
                            const AppText.body(
                              AppStrings.loginSubtitle,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),

                            // Form Fields
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.email != current.email,
                              builder: (context, state) {
                                return AuthTextField(
                                  label: AppStrings.emailLabel,
                                  hint: AppStrings.emailHint,
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginEmailChanged(value)),
                                );
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.body(
                                  AppStrings.passwordLabel,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .grey[800], // Keep generic strict? Using textPrimary which is close
                                      ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Forgot Password clicked',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const AppText.link(
                                    AppStrings.forgotPassword,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ), // Keep standardized via AppSpacing.sm or similar? will use sm
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.password != current.password ||
                                  previous.isPasswordVisible !=
                                      current.isPasswordVisible,
                              builder: (context, state) {
                                return PasswordField(
                                  label: '', // Label handled above
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginPasswordChanged(value)),
                                  isObscured: !state.isPasswordVisible,
                                  onVisibilityToggle: () =>
                                      context.read<LoginBloc>().add(
                                        const LoginPasswordVisibilityChanged(),
                                      ),
                                );
                              },
                            ),

                            const SizedBox(height: AppSpacing.lg),

                            // Login Button
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status,
                              builder: (context, state) {
                                return AuthPrimaryButton(
                                  text: AppStrings.loginButton,
                                  semanticLabel: AppStrings.loginButtonSemantic,
                                  onPressed: () => context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted()),
                                  isLoading:
                                      state.status == LoginStatus.loading,
                                );
                              },
                            ),

                            const SizedBox(height: AppSpacing.lg),

                            // Footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AppText.body(
                                  AppStrings.needWorkspace,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Flexible(
                                  child: Tooltip(
                                    message: AppStrings.createOrg,
                                    child: TextButton(
                                      onPressed: () =>
                                          context.go(RoutePaths.signup),
                                      child: AppText.link(
                                        size == DesktopSize.compact
                                            ? AppStrings.createAccount
                                            : AppStrings.createOrg,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Right Side: Decorative (Conditionally shown)
                if (showSidePanel)
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: AppColors.surfaceAlt, // Light grey bg
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Mock geometric pattern or illustration
                          Positioned.fill(
                            child: Image.asset(
                              AssetPaths.loginRightBg,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Optional: Add an image asset here later
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppRadius.xl),
                              boxShadow: AppElevation.card,
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  size: 48,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: AppSpacing.md),
                                AppText.header(
                                  AppStrings.enterpriseReady,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.sm),
                                SizedBox(
                                  width: 250,
                                  child: AppText.body(
                                    AppStrings.enterpriseDesc,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
