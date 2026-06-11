import 'dart:convert';

import 'package:dio/dio.dart';

import 'models/room.dart';

class RoomException implements Exception {
  const RoomException(this.message);
  final String message;
  @override
  String toString() => message;
}

class RoomRepository {
  RoomRepository(this._dio);

  final Dio _dio;

  Future<List<Room>> getRooms({
    String? name,
    String? minPrice,
    String? maxPrice,
    List<int> services = const [],
  }) async {
    try {
      final query = <String, dynamic>{
        if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
        if (minPrice != null && minPrice.trim().isNotEmpty)
          'minPrice': minPrice.trim(),
        if (maxPrice != null && maxPrice.trim().isNotEmpty)
          'maxPrice': maxPrice.trim(),
        if (services.isNotEmpty) 'services': services,
      };
      final res = await _dio.get('/api/rooms', queryParameters: query);
      return _asList(res.data)
          .map((e) => Room.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e, 'Could not load rooms.');
    }
  }

  Future<Room> getRoom(int id) async {
    try {
      final res = await _dio.get('/api/rooms/$id');
      return Room.fromJson(_asMap(res.data));
    } on DioException catch (e) {
      throw _mapError(e, 'Could not load this room.');
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

  List<Map> _asList(dynamic data) {
    if (data is List) return data.whereType<Map>().toList();
    if (data is String && data.trim().isNotEmpty) {
      final decoded = jsonDecode(data);
      if (decoded is List) return decoded.whereType<Map>().toList();
    }
    return const [];
  }

  RoomException _mapError(DioException e, String fallback) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const RoomException(
        'Cannot reach the server. Make sure the backend is running.',
      );
    }
    final data = e.response?.data;
    if (data is Map) {
      final dynamic msg = data['detail'] ?? data['message'] ?? data['title'];
      if (msg is String && msg.trim().isNotEmpty) return RoomException(msg);
    }
    if (data is String && data.trim().isNotEmpty && data.length < 200) {
      return RoomException(data);
    }
    return RoomException(fallback);
  }
}
