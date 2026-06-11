class RoomPolicy {
  const RoomPolicy({required this.code, required this.description});

  final String code;
  final String description;

  factory RoomPolicy.fromJson(Map<String, dynamic> json) {
    return RoomPolicy(
      code: (json['code'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }
}
