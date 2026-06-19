import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../constants/profile_options.dart';
import '../providers/profile_providers.dart';
import '../repository/models/user_profile.dart';
import '../repository/profile_repository.dart';

class ProfileEditForm extends ConsumerStatefulWidget {
  const ProfileEditForm({
    super.key,
    required this.profile,
    required this.onCancel,
    required this.onSaved,
  });

  final UserProfile profile;
  final VoidCallback onCancel;
  final VoidCallback onSaved;

  @override
  ConsumerState<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends ConsumerState<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _phone;

  String? _gender;
  String? _nationality;
  DateTime? _birthdate;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _firstName = TextEditingController(text: p.firstName);
    _lastName = TextEditingController(text: p.lastName);
    _phone = TextEditingController(text: p.phoneNumber);
    _gender = p.gender.trim().isEmpty ? null : p.gender.trim();
    _nationality = p.nationality.trim().isEmpty ? null : p.nationality.trim();
    _birthdate = p.birthDateValue;
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final payload = UpdateUserPayload(
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      phoneNumber: _phone.text.trim(),
      nationality: _nationality?.trim() ?? '',
      gender: _gender?.trim() ?? '',
      birthdate: _formatForApi(_birthdate),
    );

    final error =
        await ref.read(profileEditControllerProvider.notifier).save(payload);
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    if (error == null) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.profileUpdated)),
      );
      widget.onSaved();
    } else {
      messenger.showSnackBar(SnackBar(content: Text(error)));
    }
  }

  String _formatForApi(DateTime? date) {
    if (date == null) return '';
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '${date.year}-$mm-$dd';
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool isSaving = ref.watch(profileEditControllerProvider);
    final DateTime now = DateTime.now();

    return Form(
      key: _formKey,
      child: AppFormSection(
        actions: Row(
          children: [
            Expanded(
              child: AppSecondaryButton(
                label: l10n.commonCancel,
                expanded: true,
                onPressed: isSaving ? null : widget.onCancel,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppPrimaryButton(
                label: l10n.profileSaveChanges,
                expanded: true,
                isLoading: isSaving,
                onPressed: _submit,
              ),
            ),
          ],
        ),
        children: [
          AppTextField(
            controller: _firstName,
            label: l10n.authFirstNameLabel,
            hintText: 'Jane',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? l10n.profileFirstNameRequired
                : null,
          ),
          AppTextField(
            controller: _lastName,
            label: l10n.authLastNameLabel,
            hintText: 'Doe',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _phone,
            label: l10n.authPhoneLabel,
            hintText: '+591 70000000',
            prefixIcon: Icons.call_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          AppDropdownField<String>(
            label: l10n.authNationalityLabel,
            hintText: l10n.profileSelectNationality,
            prefixIcon: Icons.public_outlined,
            value: _nationality,
            items: ProfileOptions.nationalitiesWith(_nationality),
            onChanged: (value) => setState(() => _nationality = value),
          ),
          AppDropdownField<String>(
            label: l10n.authGenderLabel,
            hintText: l10n.authSelectGender,
            prefixIcon: Icons.wc_outlined,
            value: _gender,
            items: ProfileOptions.localizedGenders(l10n, _gender),
            onChanged: (value) => setState(() => _gender = value),
          ),
          AppDateField(
            label: l10n.profileBirthdateLabel,
            hintText: l10n.authSelectBirthDate,
            value: _birthdate,
            firstDate: DateTime(now.year - 120),
            lastDate: now,
            onChanged: (value) => setState(() => _birthdate = value),
          ),
        ],
      ),
    );
  }
}
