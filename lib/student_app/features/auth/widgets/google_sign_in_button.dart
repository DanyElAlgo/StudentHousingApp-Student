import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_lib/student_design_system/student_design_system.dart';

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
      label: 'Continue with Google',
      icon: Icons.g_mobiledata,
      expanded: true,
      onPressed: isBusy
          ? null
          : () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
    );
  }
}
