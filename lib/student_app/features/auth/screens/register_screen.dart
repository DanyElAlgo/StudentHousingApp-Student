import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

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

  static const _genderValues = ['Male', 'Female', 'Other'];

  String _genderLabel(AppLocalizations l10n, String value) {
    switch (value) {
      case 'Male':
        return l10n.authGenderMale;
      case 'Female':
        return l10n.authGenderFemale;
      default:
        return l10n.authGenderOther;
    }
  }

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
    final AppLocalizations l10n = AppLocalizations.of(context);
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
        title: Text(l10n.authAccountCreatedTitle),
        content: Text(l10n.authAccountCreatedBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonOk),
          ),
        ],
      ),
    );
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
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
      appBar: AppBar(title: Text(l10n.authCreateAccountTitle)),
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
                    l10n.authRegisterSubtitle,
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
                          label: l10n.authFirstNameLabel,
                          textInputAction: TextInputAction.next,
                          validator: (v) => AuthValidators.requiredField(
                            v,
                            l10n.authValidatorFirstNameRequired,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppTextField(
                          controller: _lastName,
                          label: l10n.authLastNameLabel,
                          textInputAction: TextInputAction.next,
                          validator: (v) => AuthValidators.requiredField(
                            v,
                            l10n.authValidatorLastNameRequired,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _email,
                    label: l10n.authEmailLabel,
                    hintText: l10n.authEmailHint,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.mail_outline,
                    validator: (v) => AuthValidators.email(v, l10n),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _phone,
                    label: l10n.authPhoneLabel,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.phone_outlined,
                    validator: (v) => AuthValidators.phone(v, l10n),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _nationality,
                    label: l10n.authNationalityLabel,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.public_outlined,
                    validator: (v) => AuthValidators.requiredField(
                      v,
                      l10n.authValidatorNationalityRequired,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DropdownButtonFormField<String>(
                    initialValue: _gender,
                    decoration: InputDecoration(labelText: l10n.authGenderLabel),
                    items: [
                      for (final g in _genderValues)
                        DropdownMenuItem(
                          value: g,
                          child: Text(_genderLabel(l10n, g)),
                        ),
                    ],
                    onChanged: (v) => setState(() => _gender = v),
                    validator: (v) =>
                        v == null ? l10n.authSelectGender : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _birthDateField,
                    readOnly: true,
                    onTap: _pickBirthDate,
                    decoration: InputDecoration(
                      labelText: l10n.authBirthDateLabel,
                      hintText: l10n.authBirthDateHint,
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                    validator: (_) =>
                        _birthDate == null ? l10n.authSelectBirthDate : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _password,
                    label: l10n.authPasswordLabel,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.lock_outline,
                    validator: (v) => AuthValidators.password(v, l10n),
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
                    label: l10n.authConfirmPasswordLabel,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline,
                    onFieldSubmitted: (_) => _submit(),
                    validator: (v) => v != _password.text
                        ? l10n.authPasswordsDoNotMatch
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppPrimaryButton(
                    label: l10n.authCreateAccountButton,
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
                        l10n.authAlreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      AppTextButton(
                        label: l10n.authLoginButton,
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
