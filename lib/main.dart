import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'student_app/core/auth/google_auth_service.dart';
import 'student_app/core/router/app_router.dart';
import 'student_design_system/student_design_system.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: appLightTheme,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
