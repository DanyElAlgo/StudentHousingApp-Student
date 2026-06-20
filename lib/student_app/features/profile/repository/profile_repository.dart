import 'dart:convert';

import 'package:dio/dio.dart';

import 'models/user_profile.dart';

class ProfileException implements Exception {
  const ProfileException(this.message);
  final String message;
  @override
  String toString() => message;
}

class UpdateUserPayload {
  const UpdateUserPayload({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.nationality,
    required this.gender,
    required this.birthdate,
  });

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String nationality;
  final String gender;

  final String birthdate;

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'nationality': nationality,
        'gender': gender,
        'birthdate': birthdate,
      };
}

class ProfileRepository {
  ProfileRepository(this._dio);

  final Dio _dio;

  Future<UserProfile> getProfile() async {
    try {
      final res = await _dio.get('/api/user');
      return UserProfile.fromJson(_asMap(res.data));
    } on DioException catch (e) {
      throw _mapError(e, 'Could not load your profile.');
    }
  }

  Future<void> updateUser(UpdateUserPayload payload) async {
    try {
      await _dio.put('/api/user', data: payload.toJson());
    } on DioException catch (e) {
      throw _mapError(e, 'Could not update your profile.');
    }
  }

  Future<void> uploadAvatar(
    List<int> bytes, {
    required String filename,
    required String subtype,
  }) async {
    try {
      final form = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          bytes,
          filename: filename,
          contentType: DioMediaType('image', subtype),
        ),
      });
      await _dio.put('/api/user/avatar', data: form);
    } on DioException catch (e) {
      throw _mapError(e, 'Could not update your profile picture.');
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

  ProfileException _mapError(DioException e, String fallback) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const ProfileException(
        'Cannot reach the server. Make sure the backend is running.',
      );
    }
    final data = e.response?.data;
    if (data is Map) {
      final dynamic msg = data['detail'] ?? data['message'] ?? data['title'];
      if (msg is String && msg.trim().isNotEmpty) return ProfileException(msg);
    }
    if (data is String && data.trim().isNotEmpty && data.length < 200) {
      final decoded = _tryDecode(data);
      if (decoded != null) return ProfileException(decoded);
      return ProfileException(data);
    }
    return ProfileException(fallback);
  }

  String? _tryDecode(String data) {
    try {
      final decoded = jsonDecode(data);
      if (decoded is Map) {
        final dynamic msg =
            decoded['detail'] ?? decoded['message'] ?? decoded['title'];
        if (msg is String && msg.trim().isNotEmpty) return msg;
      }
    } catch (_) {}
    return null;
  }
}
