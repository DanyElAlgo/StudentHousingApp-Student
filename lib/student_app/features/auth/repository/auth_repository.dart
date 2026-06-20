import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:housing_core/housing_core.dart' show AuthMeta;

import '../../../core/config/app_config.dart';
import 'models/credentials_dto.dart';
import 'models/google_auth_response.dart';
import 'models/login_dto.dart';
import 'models/register_dto.dart';

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  Options get _public => Options(extra: {AuthMeta.requiresAuthKey: false});

  Future<CredentialsDto> login(String email, String password) async {
    try {
      final res = await _dio.post(
        '/api/login',
        data: LoginDto(email: email, password: password).toJson(),
        options: _public,
      );
      return CredentialsDto.fromJson(_asMap(res.data));
    } on DioException catch (e) {
      throw _mapError(e, 'Invalid email or password.');
    }
  }

  Future<String> register(RegisterDto dto) async {
    try {
      final res = await _dio.post(
        '/api/register',
        data: dto.toJson(),
        options: _public,
      );
      final map = _asMap(res.data);
      return (map['userId'] ?? '').toString();
    } on DioException catch (e) {
      throw _mapError(e, 'Could not complete registration.');
    }
  }

  Future<GoogleAuthResponse> googleLogin(String idToken) async {
    try {
      final res = await _dio.post(
        '/api/login/google',
        data: {'idToken': idToken},
        options: _public,
      );
      return GoogleAuthResponse.fromJson(_asMap(res.data));
    } on DioException catch (e) {
      throw _mapError(e, 'Google sign-in failed.');
    }
  }

  Future<CredentialsDto> googleRegister(String idToken) async {
    try {
      final res = await _dio.post(
        '/api/register/google',
        data: {'idToken': idToken, 'role': AppConfig.studentRole},
        options: _public,
      );
      return CredentialsDto.fromJson(_asMap(res.data));
    } on DioException catch (e) {
      throw _mapError(e, 'Google registration failed.');
    }
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String && data.trim().isNotEmpty) {
      final decoded = jsonDecode(data);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return <String, dynamic>{};
  }

  AuthException _mapError(DioException e, String fallback) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const AuthException(
        'Cannot reach the server. Make sure the backend is running.',
      );
    }
    final data = e.response?.data;
    if (data is Map) {
      final dynamic msg = data['detail'] ?? data['message'] ?? data['title'];
      if (msg is String && msg.trim().isNotEmpty) return AuthException(msg);
    }
    if (data is List && data.isNotEmpty) {
      final first = data.first;
      if (first is Map && first['message'] is String) {
        return AuthException(first['message'] as String);
      }
    }
    if (data is String && data.trim().isNotEmpty && data.length < 200) {
      return AuthException(data);
    }
    return AuthException(fallback);
  }
}
