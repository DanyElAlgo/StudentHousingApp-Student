import 'room_policy.dart';

class Room {
  const Room({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.roomStatus,
    required this.imageRoomUrls,
    required this.services,
    required this.policies,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final double price;
  final String description;
  final double latitude;
  final double longitude;
  final String roomStatus;
  final List<String> imageRoomUrls;
  final List<String> services;
  final List<RoomPolicy> policies;

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String imageUrl;

  String get ownerFullName => '$firstName $lastName'.trim();

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: _toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      price: _toDouble(json['price']),
      description: (json['description'] ?? '').toString(),
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      roomStatus: (json['roomStatus'] ?? '').toString(),
      imageRoomUrls: _toStringList(json['imageRoomUrls']),
      services: _toStringList(json['services']),
      policies: _toPolicies(json['policies']),
      firstName: (json['firstName'] ?? '').toString(),
      lastName: (json['lastName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

List<String> _toStringList(dynamic value) {
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  return const [];
}

List<RoomPolicy> _toPolicies(dynamic value) {
  if (value is List) {
    return value
        .whereType<Map>()
        .map((e) => RoomPolicy.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
  return const [];
}
