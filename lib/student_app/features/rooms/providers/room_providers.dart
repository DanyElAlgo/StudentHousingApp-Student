import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_providers.dart' show dioProvider;
import '../repository/models/room.dart';
import '../repository/room_repository.dart';

final roomRepositoryProvider = Provider<RoomRepository>(
  (ref) => RoomRepository(ref.watch(dioProvider)),
);

final featuredRoomsProvider = FutureProvider.autoDispose<List<Room>>(
  (ref) => ref.watch(roomRepositoryProvider).getRooms(),
);
