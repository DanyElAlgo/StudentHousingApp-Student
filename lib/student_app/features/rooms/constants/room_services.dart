import 'package:flutter/material.dart';

class RoomServiceOption {
  const RoomServiceOption({
    required this.id,
    required this.code,
    required this.label,
    required this.icon,
  });

  final int id;
  final String code;
  final String label;
  final IconData icon;
}

const List<RoomServiceOption> kRoomServiceOptions = [
  RoomServiceOption(id: 1, code: 'service.wifi', label: 'WiFi', icon: Icons.wifi),
  RoomServiceOption(
    id: 2,
    code: 'service.kitchen',
    label: 'Kitchen',
    icon: Icons.kitchen,
  ),
  RoomServiceOption(id: 3, code: 'service.tv', label: 'TV', icon: Icons.tv),
  RoomServiceOption(
    id: 4,
    code: 'service.air-conditioner',
    label: 'Air conditioner',
    icon: Icons.ac_unit,
  ),
  RoomServiceOption(
    id: 5,
    code: 'service.gym-equipment',
    label: 'Gym equipment',
    icon: Icons.fitness_center,
  ),
];

RoomServiceOption? resolveRoomService(String service) {
  final String value = service.trim().toLowerCase();
  for (final option in kRoomServiceOptions) {
    if (option.code.toLowerCase() == value ||
        option.label.toLowerCase() == value) {
      return option;
    }
  }
  return null;
}

IconData iconForService(String service) =>
    resolveRoomService(service)?.icon ?? Icons.check_circle_outline;

String labelForService(String service) =>
    resolveRoomService(service)?.label ?? service;
