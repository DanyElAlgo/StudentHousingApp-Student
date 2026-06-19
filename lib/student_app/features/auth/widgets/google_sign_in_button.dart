import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../providers/auth_providers.dart';
import 'google_button_stub.dart'
    if (dart.library.js_interop) 'google_button_web.dart'
    as platform;

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webButton = platform.renderWebGoogleButton();
    if (webButton != null) {
      return SizedBox(height: 52, child: Center(child: webButton));
    }

    final isBusy = ref.watch(authControllerProvider.select((s) => s.isBusy));
    return AppSecondaryButton(
      label: AppLocalizations.of(context).authContinueWithGoogle,
      icon: Icons.g_mobiledata,
      expanded: true,
      onPressed: isBusy
          ? null
          : () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
    );
  }
}
