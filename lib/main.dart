import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:housing_design_system/housing_design_system.dart';

import 'l10n/generated/app_localizations.dart';
import 'student_app/core/auth/google_auth_service.dart';
import 'student_app/core/localization/locale_providers.dart';
import 'student_app/core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  try {
    await GoogleAuthService.instance.initialize();
  } catch (_) {}
  runApp(const ProviderScope(child: StudentApp()));
}

class StudentApp extends ConsumerWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Student Housing',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.student,
      locale: ref.watch(localeControllerProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeListResolutionCallback: (deviceLocales, supportedLocales) {
        // Honor the device locale when supported, otherwise fall back to English.
        if (deviceLocales != null) {
          for (final device in deviceLocales) {
            for (final supported in supportedLocales) {
              if (supported.languageCode == device.languageCode) {
                return supported;
              }
            }
          }
        }
        return const Locale('en');
      },
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
