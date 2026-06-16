import 'package:flutter/material.dart';

import '../providers/room_search_providers.dart';

class SortDropdown extends StatelessWidget {
  const SortDropdown({super.key, required this.value, required this.onChanged});

  final RoomSort value;
  final ValueChanged<RoomSort> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<RoomSort>(
      initialValue: value,
      decoration: const InputDecoration(
        labelText: 'Sort by',
        prefixIcon: Icon(Icons.sort),
        isDense: true,
      ),
      items: [
        for (final option in RoomSort.values)
          DropdownMenuItem(value: option, child: Text(option.label)),
      ],
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }
}
