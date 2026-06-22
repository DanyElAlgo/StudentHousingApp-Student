import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../repository/models/user_profile.dart';
import 'editable_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Column(
      children: [
        EditableAvatar(profile: profile),
        const SizedBox(height: AppSpacing.md),
        Text(
          profile.fullName.isEmpty
              ? AppLocalizations.of(context).profileYourProfile
              : profile.fullName,
          textAlign: TextAlign.center,
          style: text.headlineSmall,
        ),
        if (profile.email.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            profile.email,
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}
