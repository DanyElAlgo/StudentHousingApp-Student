import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';

import 'l10n/generated/app_localizations.dart';
import 'student_app/core/auth/google_auth_service.dart';
import 'student_app/core/deeplinks/room_deeplink.dart';
import 'student_app/core/localization/locale_providers.dart';
import 'student_app/core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GoogleAuthService.instance.initialize();
  } catch (_) {}
  runApp(const ProviderScope(child: StudentApp()));
}

class StudentApp extends ConsumerStatefulWidget {
  const StudentApp({super.key});

  @override
  ConsumerState<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends ConsumerState<StudentApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSub;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    // Links that launched the app from a cold start.
    try {
      final initial = await _appLinks.getInitialLink();
      if (initial != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _handleUri(initial));
      }
    } catch (_) {}

    // Links received while the app is already running.
    _linkSub = _appLinks.uriLinkStream.listen(
      _handleUri,
      onError: (_) {},
    );
  }

  void _handleUri(Uri uri) {
    final roomId = parseRoomDeepLink(uri);
    if (roomId == null || !mounted) return;
    ref.read(goRouterProvider).push('/room/$roomId');
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
