import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

import '../../../core/localization/locale_providers.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  static const List<AppDropdownItem<String>> _items = [
    AppDropdownItem<String>(value: 'en', label: 'English'),
    AppDropdownItem<String>(value: 'es', label: 'Español'),
    AppDropdownItem<String>(value: 'pt', label: 'Português'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String current = Localizations.localeOf(context).languageCode;

    return AppCard(
      bordered: true,
      child: AppDropdownField<String>(
        label: l10n.profileLanguageLabel,
        prefixIcon: Icons.language_outlined,
        value: current,
        items: _items,
        onChanged: (code) {
          if (code != null) {
            ref
                .read(localeControllerProvider.notifier)
                .setLocale(Locale(code));
          }
        },
      ),
    );
  }
}
