import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../rooms/providers/room_providers.dart';
import '../../rooms/repository/models/room.dart';
import '../../rooms/repository/room_repository.dart';

enum RoomSort { priceAsc, priceDesc, nameAsc, nameDesc }

@immutable
class RoomSearchState {
  const RoomSearchState({
    this.name = '',
    this.minPrice = '',
    this.maxPrice = '',
    this.serviceIds = const {},
    this.sort = RoomSort.priceAsc,
    this.results = const AsyncValue.loading(),
  });

  final String name;
  final String minPrice;
  final String maxPrice;
  final Set<int> serviceIds;
  final RoomSort sort;
  final AsyncValue<List<Room>> results;

  RoomSearchState copyWith({
    String? name,
    String? minPrice,
    String? maxPrice,
    Set<int>? serviceIds,
    RoomSort? sort,
    AsyncValue<List<Room>>? results,
  }) {
    return RoomSearchState(
      name: name ?? this.name,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      serviceIds: serviceIds ?? this.serviceIds,
      sort: sort ?? this.sort,
      results: results ?? this.results,
    );
  }
}

final roomSearchControllerProvider =
    NotifierProvider<RoomSearchController, RoomSearchState>(
  RoomSearchController.new,
);

class RoomSearchController extends Notifier<RoomSearchState> {
  @override
  RoomSearchState build() => const RoomSearchState();

  RoomRepository get _repo => ref.read(roomRepositoryProvider);

  void applyFilters({String? name, String? minPrice, String? maxPrice}) {
    state = state.copyWith(
      name: name ?? state.name,
      minPrice: minPrice ?? state.minPrice,
      maxPrice: maxPrice ?? state.maxPrice,
      serviceIds: const {},
    );
    search();
  }

  void setName(String value) => state = state.copyWith(name: value);

  void setPriceRange({String? min, String? max}) =>
      state = state.copyWith(minPrice: min, maxPrice: max);

  void toggleService(int id) {
    final next = Set<int>.from(state.serviceIds);
    if (!next.add(id)) next.remove(id);
    state = state.copyWith(serviceIds: next);
  }

  void clearServices() => state = state.copyWith(serviceIds: const {});

  void setSort(RoomSort sort) {
    state = state.copyWith(sort: sort);
    state.results.whenData((rooms) {
      state = state.copyWith(results: AsyncData(_sorted(rooms)));
    });
  }

  Future<void> search() async {
    state = state.copyWith(results: const AsyncValue.loading());
    try {
      final rooms = await _repo.getRooms(
        name: state.name,
        minPrice: state.minPrice,
        maxPrice: state.maxPrice,
        services: state.serviceIds.toList(),
      );
      state = state.copyWith(results: AsyncData(_sorted(rooms)));
    } on RoomException catch (e) {
      state = state.copyWith(
        results: AsyncError(e.message, StackTrace.current),
      );
    } catch (e) {
      state = state.copyWith(
        results: AsyncError(
          'Something went wrong. Please try again.',
          StackTrace.current,
        ),
      );
    }
  }

  List<Room> _sorted(List<Room> rooms) {
    final list = List<Room>.from(rooms);
    switch (state.sort) {
      case RoomSort.priceAsc:
        list.sort((a, b) => a.price.compareTo(b.price));
      case RoomSort.priceDesc:
        list.sort((a, b) => b.price.compareTo(a.price));
      case RoomSort.nameAsc:
        list.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
      case RoomSort.nameDesc:
        list.sort(
          (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
    }
    return list;
  }
}
