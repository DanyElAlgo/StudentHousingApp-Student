import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/bookings/screens/bookings_screen.dart';
import '../../features/chat/chat_thread_args.dart';
import '../../features/chat/screens/chat_list_screen.dart';
import '../../features/chat/screens/chat_thread_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/roomDetails/screens/room_details_screen.dart';
import '../../features/roomSearch/screens/room_search_screen.dart';
import '../widgets/app_shell.dart';

const String studentInitialLocation = '/home';

List<RouteBase> studentExperienceRoutes() => [
  GoRoute(
    path: '/room/:id',
    builder: (_, state) => RoomDetailsScreen(
      roomId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
    ),
  ),

  GoRoute(
    path: '/chat/:chatId',
    builder: (_, state) => ChatThreadScreen(
      chatId: int.tryParse(state.pathParameters['chatId'] ?? '') ?? 0,
      args: state.extra as ChatThreadArgs?,
    ),
  ),

  StatefulShellRoute.indexedStack(
    builder: (_, _, navigationShell) =>
        AppShell(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/chat', builder: (_, _) => const ChatListScreen()),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/rooms', builder: (_, _) => const RoomSearchScreen()),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/bookings', builder: (_, _) => const BookingsScreen()),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen()),
        ],
      ),
    ],
  ),
];

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(
    authControllerProvider.select((s) => s.status),
    (_, _) => refresh.value++,
  );

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final status = ref.read(authControllerProvider).status;
      final location = state.matchedLocation;

      if (status == AuthStatus.unknown) {
        return location == '/' ? null : '/';
      }

      final onAuthRoute = location == '/login' || location == '/register';

      if (status == AuthStatus.unauthenticated) {
        return onAuthRoute ? null : '/login';
      }

      if (onAuthRoute || location == '/') return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const _SplashScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),

      ...studentExperienceRoutes(),
    ],
  );
});

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
