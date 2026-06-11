abstract final class RoomStatus {
  RoomStatus._();

  static const String available = 'Available';
  static const String booked = 'Booked';
  static const String unavailable = 'Unavailable';

  static bool isAvailable(String status) =>
      status.trim().toLowerCase() == available.toLowerCase();
}
