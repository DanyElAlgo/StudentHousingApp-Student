import 'package:dio/dio.dart';

import '../database/app_database.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.db,
    required this.refreshDio,
    this.onSessionExpired,
  });

  final AppDatabase db;

  final Dio refreshDio;

  final Future<void> Function()? onSessionExpired;

  static const String _retriedFlag = '__retried__';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.headers.containsKey('Authorization')) {
      final session = await db.readSession();
      if (session != null) {
        options.headers['Authorization'] = 'Bearer ${session.access}';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    final path = err.requestOptions.path;
    final alreadyRetried = err.requestOptions.extra[_retriedFlag] == true;

    final isAuthEndpoint =
        path.contains('/api/login') || path.contains('/api/register');

    if (status != 401 || alreadyRetried || isAuthEndpoint) {
      return handler.next(err);
    }

    final session = await db.readSession();
    if (session != null) {
      try {
        final res = await refreshDio.post(
          '/api/login/refresh-token',
          data: {'refreshToken': session.refresh},
        );
        final data = res.data;
        final map = data is Map ? data : const <String, dynamic>{};
        final newAccess = map['accessToken'] as String?;
        final newRefresh = map['refreshToken'] as String?;
        if (newAccess != null && newRefresh != null) {
          await db.saveSession(newAccess, newRefresh);
          final opts = err.requestOptions
            ..extra[_retriedFlag] = true
            ..headers['Authorization'] = 'Bearer $newAccess';
          final retried = await refreshDio.fetch<dynamic>(opts);
          return handler.resolve(retried);
        }
      } catch (_) {
      }
    }

    await db.clearSession();
    if (onSessionExpired != null) await onSessionExpired!();
    handler.next(err);
  }
}
