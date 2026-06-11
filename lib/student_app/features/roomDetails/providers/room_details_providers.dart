import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bookings/providers/booking_providers.dart';
import '../../bookings/repository/booking_repository.dart';
import '../../rooms/providers/room_providers.dart';
import '../../rooms/repository/models/room.dart';

class RoomDetailsData {
  const RoomDetailsData({required this.room, required this.hasBooking});

  final Room room;
  final bool hasBooking;
}

final roomDetailsProvider =
    FutureProvider.autoDispose.family<RoomDetailsData, int>((ref, id) async {
  final room = await ref.watch(roomRepositoryProvider).getRoom(id);
  bool hasBooking = false;
  try {
    hasBooking = await ref.watch(bookingRepositoryProvider).hasBooking(id);
  } catch (_) {
  }
  return RoomDetailsData(room: room, hasBooking: hasBooking);
});

final bookingActionProvider =
    NotifierProvider.autoDispose<BookingActionController, bool>(
  BookingActionController.new,
);

class BookingActionController extends Notifier<bool> {
  @override
  bool build() => false;

  BookingRepository get _bookings => ref.read(bookingRepositoryProvider);

  Future<String?> book(int roomId) async {
    state = true;
    try {
      await _bookings.book(roomId);
      _refresh(roomId);
      return null;
    } on BookingException catch (e) {
      return e.message;
    } catch (_) {
      return 'Could not book this room.';
    } finally {
      state = false;
    }
  }

  Future<String?> cancel(int roomId) async {
    state = true;
    try {
      await _bookings.cancel(roomId);
      _refresh(roomId);
      return null;
    } on BookingException catch (e) {
      return e.message;
    } catch (_) {
      return 'Could not cancel the request.';
    } finally {
      state = false;
    }
  }

  void _refresh(int roomId) {
    ref.invalidate(roomDetailsProvider(roomId));
    ref.invalidate(featuredRoomsProvider);
  }
}
