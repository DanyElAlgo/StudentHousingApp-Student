class BookingStudent {
  const BookingStudent({
    required this.id,
    required this.roomId,
    required this.bookingStatus,
    required this.bookingStatusId,
    required this.bookingRoomName,
  });

  final int id;
  final int roomId;
  final String bookingStatus;
  final int bookingStatusId;
  final String bookingRoomName;

  factory BookingStudent.fromJson(Map<String, dynamic> json) {
    return BookingStudent(
      id: _toInt(json['id']),
      roomId: _toInt(json['roomId']),
      bookingStatus: (json['bookingStatus'] ?? '').toString(),
      bookingStatusId: _toInt(json['bookingStatusId']),
      bookingRoomName: (json['bookingRoomName'] ?? '').toString(),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}
