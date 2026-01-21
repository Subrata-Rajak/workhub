import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/desktop_layout_helper.dart';
import '../../../../core/layout/desktop_breakpoints.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../utils/asset_paths.dart';
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
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: AppText.body(
                  state.errorMessage ?? 'Authentication Failure',
                ),
              ),
            );
        } else if (state.status == LoginStatus.success) {
          context.go(RoutePaths.dashboard);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: DesktopLayoutHelper.getHorizontalPadding(
                          size,
                        ),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              DesktopLayoutHelper.getMaxContentWidth(size) /
                              2, // Half width or reasonable form max width
                        ),
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
                                    color: const Color(0xFF2E6B66),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.apps,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const AppText.header(
                                  'Admin Console',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 64),

                            // Heading
                            const AppText.title(
                              'Welcome back',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const AppText.body(
                              'Enter your credentials to access the admin console.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Form Fields
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.email != current.email,
                              builder: (context, state) {
                                return AuthTextField(
                                  label: 'Email address',
                                  hint: 'e.g. admin@company.com',
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginEmailChanged(value)),
                                );
                              },
                            ),
                            const SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.body(
                                  'Password',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
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
                                    'Forgot password?',
                                    style: TextStyle(color: Color(0xFF2E6B66)),
                                  ),
                                ),
                              ],
                            ),
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

                            const SizedBox(height: 32),

                            // Login Button
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status,
                              builder: (context, state) {
                                return AuthPrimaryButton(
                                  text: 'Login to Console',
                                  semanticLabel: 'Login to Admin Console',
                                  onPressed: () => context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted()),
                                  isLoading:
                                      state.status == LoginStatus.loading,
                                );
                              },
                            ),

                            const SizedBox(height: 32),

                            // Footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AppText.body(
                                  'Need a workspace? ',
                                  style: TextStyle(color: Color(0xFF6B7280)),
                                ),
                                Flexible(
                                  child: Tooltip(
                                    message: 'Create a new organization',
                                    child: TextButton(
                                      onPressed: () =>
                                          context.go(RoutePaths.signup),
                                      child: AppText.link(
                                        size == DesktopSize.compact
                                            ? 'Create account'
                                            : 'Create a new organization',
                                        style: const TextStyle(
                                          color: Color(0xFF2E6B66),
                                          fontWeight: FontWeight.bold,
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
                      color: const Color(0xFFF3F4F6), // Light grey bg
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
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(13), // ~0.05
                                  blurRadius: 32,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  size: 48,
                                  color: Color(0xFF2E6B66),
                                ),
                                SizedBox(height: 16),
                                AppText.header(
                                  'Enterprise Ready',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 250,
                                  child: AppText.body(
                                    'Secure multi-tenant infrastructure designed for rapid scaling.',
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
