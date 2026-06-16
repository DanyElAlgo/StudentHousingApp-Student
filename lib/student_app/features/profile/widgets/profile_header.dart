import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

import '../repository/models/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    final bool hasImage = profile.imageUrl.trim().isNotEmpty;

    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: colors.primary,
          backgroundImage: hasImage ? NetworkImage(profile.imageUrl) : null,
          child: hasImage
              ? null
              : Icon(Icons.person, size: 44, color: colors.onPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          profile.fullName.isEmpty ? 'Your profile' : profile.fullName,
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
