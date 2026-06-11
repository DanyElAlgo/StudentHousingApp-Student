import 'dart:convert';

import 'package:dio/dio.dart';

class BookingException implements Exception {
  const BookingException(this.message);
  final String message;
  @override
  String toString() => message;
}

class BookingRepository {
  BookingRepository(this._dio);

  final Dio _dio;

  Future<bool> hasBooking(int roomId) async {
    try {
      final res = await _dio.get('/api/bookings/$roomId');
      return _asBool(res.data);
    } on DioException catch (e) {
      throw _mapError(e, 'Could not check booking status.');
    }
  }

  Future<void> book(int roomId) async {
    try {
      await _dio.post('/api/bookings', data: {'roomId': roomId});
    } on DioException catch (e) {
      throw _mapError(e, 'Could not book this room.');
    }
  }

  Future<void> cancel(int roomId) async {
    try {
      await _dio.delete('/api/bookings/$roomId');
    } on DioException catch (e) {
      throw _mapError(e, 'Could not cancel the request.');
    }
  }

  bool _asBool(dynamic data) {
    if (data is bool) return data;
    if (data is String) return data.trim().toLowerCase() == 'true';
    if (data is num) return data != 0;
    return false;
  }

  BookingException _mapError(DioException e, String fallback) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const BookingException(
        'Cannot reach the server. Make sure the backend is running.',
      );
    }
    final data = e.response?.data;
    if (data is Map) {
      final dynamic msg = data['detail'] ?? data['message'] ?? data['title'];
      if (msg is String && msg.trim().isNotEmpty) return BookingException(msg);
    }
    if (data is String && data.trim().isNotEmpty && data.length < 200) {
      final decoded = _tryDecode(data);
      if (decoded != null) return BookingException(decoded);
      return BookingException(data);
    }
    return BookingException(fallback);
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
