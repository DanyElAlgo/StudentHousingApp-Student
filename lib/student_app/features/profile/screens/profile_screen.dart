import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../auth/providers/auth_providers.dart';
import '../providers/profile_providers.dart';
import '../repository/models/user_profile.dart';
import '../widgets/language_selector.dart';
import '../widgets/profile_edit_form.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_view.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<UserProfile> profileAsync =
        ref.watch(userProfileProvider);

    return AppScaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(userProfileProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: [
            ...profileAsync.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.only(top: AppSpacing.xxl),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
              error: (err, _) => [
                _ProfileMessage(
                  icon: Icons.cloud_off_outlined,
                  message: '$err',
                  onRetry: () => ref.invalidate(userProfileProvider),
                ),
              ],
              data: (profile) => [
                ProfileHeader(profile: profile),
                const SizedBox(height: AppSpacing.xl),
                if (_editing)
                  ProfileEditForm(
                    profile: profile,
                    onCancel: () => setState(() => _editing = false),
                    onSaved: () => setState(() => _editing = false),
                  )
                else ...[
                  ProfileInfoView(profile: profile),
                  const SizedBox(height: AppSpacing.lg),
                  const LanguageSelector(),
                  const SizedBox(height: AppSpacing.xl),
                  AppPrimaryButton(
                    label: l10n.profileEditButton,
                    icon: Icons.edit_outlined,
                    expanded: true,
                    onPressed: () => setState(() => _editing = true),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppSecondaryButton(
                    label: l10n.profileLogout,
                    icon: Icons.logout,
                    expanded: true,
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).logout(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMessage extends StatelessWidget {
  const _ProfileMessage({
    required this.icon,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.onSurfaceVariant),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppSecondaryButton(
              label: AppLocalizations.of(context).commonRetry,
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    );
  }
}
