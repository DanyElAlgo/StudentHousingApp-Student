import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

import '../providers/auth_providers.dart';
import '../widgets/auth_form_header.dart';
import '../widgets/auth_validators.dart';
import '../widgets/google_sign_in_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(authControllerProvider.notifier)
          .login(_email.text.trim(), _password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = ref.watch(authControllerProvider.select((s) => s.isBusy));

    ref.listen(authControllerProvider.select((s) => s.errorMessage), (_, msg) {
      if (msg != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(msg)));
        ref.read(authControllerProvider.notifier).clearError();
      }
    });

    return AppScaffold(
      padded: true,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  const AuthFormHeader(
                    title: 'Welcome back',
                    subtitle: 'Log in to find your next student home.',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    controller: _email,
                    label: 'Email',
                    hintText: 'you@example.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.mail_outline,
                    validator: AuthValidators.email,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _password,
                    label: 'Password',
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline,
                    onFieldSubmitted: (_) => _submit(),
                    validator: AuthValidators.loginPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppPrimaryButton(
                    label: 'Log in',
                    expanded: true,
                    isLoading: isBusy,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _OrDivider(),
                  const SizedBox(height: AppSpacing.lg),
                  const GoogleSignInButton(),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      AppTextButton(
                        label: 'Register',
                        onPressed: () => context.push('/register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
