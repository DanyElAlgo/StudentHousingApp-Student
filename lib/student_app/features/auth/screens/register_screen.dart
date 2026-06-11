import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

import '../providers/auth_providers.dart';
import '../repository/models/register_dto.dart';
import '../widgets/auth_validators.dart';
import '../widgets/google_sign_in_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _nationality = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _birthDateField = TextEditingController();

  String? _gender;
  DateTime? _birthDate;
  bool _obscure = true;

  static const _genders = ['Masculino', 'Femenino', 'Otro'];

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _nationality.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _birthDateField.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _birthDateField.text = _formatDate(picked);
      });
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final dto = RegisterDto(
      email: _email.text.trim(),
      password: _password.text,
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      phoneNumber: _phone.text.trim(),
      nationality: _nationality.text.trim(),
      gender: _gender!,
      birthDate: _formatDate(_birthDate!),
    );

    final created = await ref.read(authControllerProvider.notifier).register(dto);
    if (!created || !mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account created'),
        content: const Text(
          'Check your email to confirm your account, then log in.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (mounted) context.go('/login');
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
      appBar: AppBar(title: const Text('Create account')),
      padded: true,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Join as a student to browse and book rooms.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _firstName,
                          label: 'First name',
                          textInputAction: TextInputAction.next,
                          validator: (v) =>
                              AuthValidators.required(v, 'first name'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppTextField(
                          controller: _lastName,
                          label: 'Last name',
                          textInputAction: TextInputAction.next,
                          validator: (v) =>
                              AuthValidators.required(v, 'last name'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
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
                    controller: _phone,
                    label: 'Phone number',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.phone_outlined,
                    validator: AuthValidators.phone,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _nationality,
                    label: 'Nationality',
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.public_outlined,
                    validator: (v) => AuthValidators.required(v, 'nationality'),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DropdownButtonFormField<String>(
                    initialValue: _gender,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    items: [
                      for (final g in _genders)
                        DropdownMenuItem(value: g, child: Text(g)),
                    ],
                    onChanged: (v) => setState(() => _gender = v),
                    validator: (v) => v == null ? 'Select your gender' : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _birthDateField,
                    readOnly: true,
                    onTap: _pickBirthDate,
                    decoration: const InputDecoration(
                      labelText: 'Birth date',
                      hintText: 'yyyy-mm-dd',
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    validator: (_) =>
                        _birthDate == null ? 'Select your birth date' : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _password,
                    label: 'Password',
                    obscureText: _obscure,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.lock_outline,
                    validator: AuthValidators.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _confirmPassword,
                    label: 'Confirm password',
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline,
                    onFieldSubmitted: (_) => _submit(),
                    validator: (v) => v != _password.text
                        ? 'Passwords do not match'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppPrimaryButton(
                    label: 'Create account',
                    expanded: true,
                    isLoading: isBusy,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const GoogleSignInButton(),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      AppTextButton(
                        label: 'Log in',
                        onPressed: () => context.go('/login'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
