import 'package:flutter/material.dart';
import 'package:housing_design_system/housing_design_system.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppTextField(
            controller: minController,
            label: 'Min price',
            hintText: '0',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onChanged?.call(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppTextField(
            controller: maxController,
            label: 'Max price',
            hintText: 'Any',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onChanged?.call(),
          ),
        ),
      ],
    );
  }
}
