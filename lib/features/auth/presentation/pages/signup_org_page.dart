import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layout/desktop_layout_helper.dart';
import '../../../../core/layout/desktop_breakpoints.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/ui/app_text.dart';
import '../../bloc/signup_bloc/signup_bloc.dart';
import '../../bloc/signup_bloc/signup_event.dart';
import '../../bloc/signup_bloc/signup_state.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_field.dart';

class SignupOrgPage extends StatelessWidget {
  const SignupOrgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SignupOrgForm(),
    );
  }
}

class SignupOrgForm extends StatelessWidget {
  const SignupOrgForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SignupStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: AppText.body(state.errorMessage ?? 'Signup Failed'),
              ),
            );
        } else if (state.status == SignupStatus.success) {
          context.go(RoutePaths.dashboard);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: const AppText.header(
            'ProjectFlow',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: const Icon(Icons.apps, color: Color(0xFF2E6B66)),
          actions: [
            TextButton(
              onPressed: () => context.go(RoutePaths.login),
              child: const AppText.link('Already have an account? Log in'),
            ),
            const SizedBox(width: 24),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final size = DesktopLayoutHelper.getSize(constraints.maxWidth);
            final isCompact = size == DesktopSize.compact;
            final horizontalPadding = DesktopLayoutHelper.getHorizontalPadding(
              size,
            );
            final maxContentWidth = DesktopLayoutHelper.getMaxContentWidth(
              size,
            );

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: 48,
                    horizontal: horizontalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText.title(
                          'Setup New Organization',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const AppText.body(
                          "You're one step away from launching your shared workspace. Complete these details to get started.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Layout Decision: Column (compact) vs Row (standard+)
                        if (isCompact) ...[
                          const _UserDetailsCard(),
                          const SizedBox(height: 24),
                          const _OrganizationDetailsCard(),
                        ] else
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _UserDetailsCard()),
                              SizedBox(width: 24),
                              Expanded(child: _OrganizationDetailsCard()),
                            ],
                          ),

                        const SizedBox(height: 48),

                        // Footer
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(13), // 0.05
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              BlocBuilder<SignupBloc, SignupState>(
                                buildWhen: (p, c) =>
                                    p.termsAccepted != c.termsAccepted,
                                builder: (context, state) => Checkbox(
                                  value: state.termsAccepted,
                                  onChanged: (v) => context
                                      .read<SignupBloc>()
                                      .add(SignupTermsChanged(v ?? false)),
                                  activeColor: const Color(0xFF2E6B66),
                                ),
                              ),
                              // Flexible text for small screens
                              const Expanded(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    AppText.body('I agree to the '),
                                    AppText.link(
                                      'Terms of Service',
                                      style: TextStyle(
                                        color: Color(0xFF2E6B66),
                                      ),
                                    ),
                                    AppText.body(' and '),
                                    AppText.link(
                                      'Privacy Policy',
                                      style: TextStyle(
                                        color: Color(0xFF2E6B66),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isCompact)
                                const Spacer(), // Spacer only on larger screens to push button right
                              SizedBox(width: isCompact ? 16 : 0),
                              SizedBox(
                                width: isCompact ? 150 : 300,
                                child: BlocBuilder<SignupBloc, SignupState>(
                                  buildWhen: (p, c) => p.status != c.status,
                                  builder: (context, state) => AuthPrimaryButton(
                                    text: isCompact
                                        ? 'Create Account'
                                        : 'Create account & organization', // Shorten text on compact
                                    semanticLabel:
                                        'Create account & organization', // Full intent always
                                    onPressed: () => context
                                        .read<SignupBloc>()
                                        .add(const SignupSubmitted()),
                                    isLoading:
                                        state.status == SignupStatus.loading,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _UserDetailsCard extends StatelessWidget {
  const _UserDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal.withAlpha(26), // 0.1
                child: const Icon(Icons.person, color: Colors.teal),
              ),
              const SizedBox(width: 12),
              const AppText.header(
                'User Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen: (p, c) => p.name != c.name,
            builder: (context, state) => AuthTextField(
              label: 'FULL NAME',
              hint: 'Jane Doe',
              onChanged: (v) =>
                  context.read<SignupBloc>().add(SignupNameChanged(v)),
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen: (p, c) => p.email != c.email,
            builder: (context, state) => AuthTextField(
              label: 'WORK EMAIL',
              hint: 'jane@company.com',
              onChanged: (v) =>
                  context.read<SignupBloc>().add(SignupEmailChanged(v)),
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen: (p, c) =>
                p.password != c.password ||
                p.isPasswordVisible != c.isPasswordVisible,
            builder: (context, state) => PasswordField(
              label: 'PASSWORD',
              hint: '........',
              onChanged: (v) =>
                  context.read<SignupBloc>().add(SignupPasswordChanged(v)),
              isObscured: !state.isPasswordVisible,
              onVisibilityToggle: () => context.read<SignupBloc>().add(
                const SignupPasswordVisibilityChanged(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const AppText.body(
            'At least 8 characters.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _OrganizationDetailsCard extends StatelessWidget {
  const _OrganizationDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal.withAlpha(26), // 0.1
                    child: const Icon(Icons.business, color: Colors.teal),
                  ),
                  const SizedBox(width: 12),
                  const AppText.header(
                    'Organization Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              BlocBuilder<SignupBloc, SignupState>(
                buildWhen: (p, c) => p.companyName != c.companyName,
                builder: (context, state) => AuthTextField(
                  label: 'COMPANY NAME',
                  hint: 'Acme Inc.',
                  onChanged: (v) => context.read<SignupBloc>().add(
                    SignupCompanyNameChanged(v),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.teal.withAlpha(13), // 0.05
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.withAlpha(26)), // 0.1
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.admin_panel_settings_outlined, color: Colors.teal),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.header(
                      'Administrator Privileges',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 4),
                    AppText.body(
                      'As the creator of this organization, you will be assigned the Owner role. You can invite team members later.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.grid_view, size: 48, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
