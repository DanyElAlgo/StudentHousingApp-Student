import 'package:flutter/material.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../providers/room_search_providers.dart';

class SortDropdown extends StatelessWidget {
  const SortDropdown({super.key, required this.value, required this.onChanged});

  final RoomSort value;
  final ValueChanged<RoomSort> onChanged;

  static String labelFor(AppLocalizations l10n, RoomSort sort) {
    switch (sort) {
      case RoomSort.priceAsc:
        return l10n.sortPriceAsc;
      case RoomSort.priceDesc:
        return l10n.sortPriceDesc;
      case RoomSort.nameAsc:
        return l10n.sortNameAsc;
      case RoomSort.nameDesc:
        return l10n.sortNameDesc;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return DropdownButtonFormField<RoomSort>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: l10n.sortByLabel,
        prefixIcon: const Icon(Icons.sort),
        isDense: true,
      ),
      items: [
        for (final option in RoomSort.values)
          DropdownMenuItem(value: option, child: Text(labelFor(l10n, option))),
      ],
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }
}
