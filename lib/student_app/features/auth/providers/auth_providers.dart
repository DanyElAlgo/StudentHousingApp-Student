import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_core/housing_core.dart';

import '../../../core/auth/google_auth_service.dart';
import '../../../core/database/app_database.dart';
import '../repository/auth_repository.dart';
import '../repository/models/register_dto.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@immutable
class AuthState {
  const AuthState({required this.status, this.isBusy = false, this.errorMessage});

  final AuthStatus status;
  final bool isBusy;
  final String? errorMessage;
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = SecureTokenStorage();
  return DioClient.create(
    tokenStorage: tokenStorage,
    refreshClient: DioClient.createRefreshClient(),
    onSessionExpired: () =>
        ref.read(authControllerProvider.notifier).handleSessionExpired(),
  );
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(dioProvider)),
);

final logoutHookProvider = Provider<void Function()?>((_) => null);

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  StreamSubscription<String>? _googleSub;

  @override
  AuthState build() {
    _restoreSession();
    if (kIsWeb) {
      _googleSub = GoogleAuthService.instance.idTokens.listen(
        _processGoogleIdToken,
        onError: (_) {},
      );
      ref.onDispose(() => _googleSub?.cancel());
    }
    return const AuthState(status: AuthStatus.unknown);
  }

  final SecureTokenStorage _tokenStorage = SecureTokenStorage();

  AppDatabase get _db => ref.read(databaseProvider);
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _restoreSession() async {
    final hasSession = await _tokenStorage.hasTokens();
    state = AuthState(
      status:
          hasSession ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  Future<void> login(String email, String password) async {
    state = AuthState(status: state.status, isBusy: true);
    try {
      final creds = await _repo.login(email, password);
      await _tokenStorage.saveTokens(
        accessToken: creds.accessToken,
        refreshToken: creds.refreshToken,
      );
      state = const AuthState(status: AuthStatus.authenticated);
    } on AuthException catch (e) {
      state = AuthState(status: AuthStatus.unauthenticated, errorMessage: e.message);
    } catch (_) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<bool> register(RegisterDto dto) async {
    state = AuthState(status: state.status, isBusy: true);
    try {
      await _repo.register(dto);
      state = AuthState(status: state.status);
      return true;
    } on AuthException catch (e) {
      state = AuthState(status: state.status, errorMessage: e.message);
      return false;
    } catch (_) {
      state = AuthState(
        status: state.status,
        errorMessage: 'Something went wrong. Please try again.',
      );
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    state = AuthState(status: state.status, isBusy: true);
    try {
      final idToken = await GoogleAuthService.instance.signInAndGetIdToken();
      if (idToken == null) {
        state = AuthState(status: state.status); // cancelled / unsupported
        return;
      }
      await _processGoogleIdToken(idToken);
    } catch (_) {
      state = AuthState(status: state.status, errorMessage: 'Google sign-in failed.');
    }
  }

  Future<void> _processGoogleIdToken(String idToken) async {
    state = AuthState(status: state.status, isBusy: true);
    try {
      final resp = await _repo.googleLogin(idToken);
      final creds = (resp.isNewUser || resp.credentials == null)
          ? await _repo.googleRegister(idToken)
          : resp.credentials!;
      await _tokenStorage.saveTokens(
        accessToken: creds.accessToken,
        refreshToken: creds.refreshToken,
      );
      state = const AuthState(status: AuthStatus.authenticated);
    } on AuthException catch (e) {
      state = AuthState(status: state.status, errorMessage: e.message);
    } catch (_) {
      state = AuthState(status: state.status, errorMessage: 'Google sign-in failed.');
    }
  }

  Future<void> logout() async {
    await _tokenStorage.clear();
    await _db.clearChatData();
    try {
      await GoogleAuthService.instance.signOut();
    } catch (_) {}
    ref.read(logoutHookProvider)?.call();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void handleSessionExpired() {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = AuthState(status: state.status, isBusy: state.isBusy);
    }
  }
}
