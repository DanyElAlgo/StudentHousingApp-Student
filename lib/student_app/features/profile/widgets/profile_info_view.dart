import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../constants/profile_options.dart';
import '../repository/models/user_profile.dart';

class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String gender = profile.gender.trim().isEmpty
        ? profile.gender
        : ProfileOptions.genderLabel(l10n, profile.gender);

    return AppCard(
      bordered: true,
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.mail_outline,
            label: l10n.authEmailLabel,
            value: profile.email,
            trailing: '',
          ),
          _InfoRow(
            icon: Icons.call_outlined,
            label: l10n.authPhoneLabel,
            value: profile.phoneNumber,
          ),
          _InfoRow(
            icon: Icons.public_outlined,
            label: l10n.authNationalityLabel,
            value: profile.nationality,
          ),
          _InfoRow(
            icon: Icons.wc_outlined,
            label: l10n.authGenderLabel,
            value: gender,
          ),
          _InfoRow(
            icon: Icons.cake_outlined,
            label: l10n.profileBirthdateLabel,
            value: _formatBirthdate(profile),
            isLast: true,
          ),
        ],
      ),
    );
  }

  static String _formatBirthdate(UserProfile profile) {
    final date = profile.birthDateValue;
    if (date != null) {
      final mm = date.month.toString().padLeft(2, '0');
      final dd = date.day.toString().padLeft(2, '0');
      return '$mm/$dd/${date.year}';
    }
    return profile.birthdate;
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? trailing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final bool hasValue = value.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.onSurfaceVariant),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: text.bodySmall
                      ?.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  hasValue ? value : AppLocalizations.of(context).commonNotSet,
                  style: text.bodyLarge?.copyWith(
                    color: hasValue
                        ? null
                        : AppColors.onSurfaceVariant,
                    fontStyle: hasValue ? null : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.md),
            Text(
              trailing!,
              style: text.bodySmall
                  ?.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
