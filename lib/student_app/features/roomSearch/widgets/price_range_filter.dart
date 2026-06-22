import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

class PriceRangeFilter extends StatelessWidget {
  const PriceRangeFilter({
    super.key,
    required this.minController,
    required this.maxController,
    this.onChanged,
  });

  final TextEditingController minController;
  final TextEditingController maxController;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppTextField(
            controller: minController,
            label: l10n.searchMinPrice,
            hintText: '0',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onChanged?.call(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppTextField(
            controller: maxController,
            label: l10n.searchMaxPrice,
            hintText: l10n.searchMaxPriceHintAny,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onChanged?.call(),
          ),
        ),
      ],
    );
  }
}
