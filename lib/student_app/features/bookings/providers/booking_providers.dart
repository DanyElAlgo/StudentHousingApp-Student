import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_providers.dart' show dioProvider;
import '../repository/booking_repository.dart';
import '../repository/models/booking_student.dart';

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => BookingRepository(ref.watch(dioProvider)),
);

final studentBookingsProvider =
    FutureProvider.autoDispose<List<BookingStudent>>(
  (ref) => ref.watch(bookingRepositoryProvider).getBookings(),
);
