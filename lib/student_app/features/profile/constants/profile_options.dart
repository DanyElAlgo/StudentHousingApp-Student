import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

abstract final class ProfileOptions {
  ProfileOptions._();

  static const List<String> _genderValues = ['Male', 'Female', 'Other'];

  static const List<String> _nationalityValues = [
    'Argentina',
    'Bolivia',
    'Brazil',
    'Chile',
    'Colombia',
    'Costa Rica',
    'Cuba',
    'Dominican Republic',
    'Ecuador',
    'El Salvador',
    'Guatemala',
    'Honduras',
    'Mexico',
    'Nicaragua',
    'Panama',
    'Paraguay',
    'Peru',
    'Puerto Rico',
    'Uruguay',
    'Venezuela',
  ];

  static List<AppDropdownItem<String>> get nationalities =>
      _toItems(_nationalityValues);

  static List<AppDropdownItem<String>> nationalitiesWith(String? current) =>
      _withValue(nationalities, current);

  static String genderLabel(AppLocalizations l10n, String value) {
    switch (value.trim().toLowerCase()) {
      case 'male':
      case 'masculino':
        return l10n.authGenderMale;
      case 'female':
      case 'femenino':
        return l10n.authGenderFemale;
      case 'other':
      case 'otro':
        return l10n.authGenderOther;
      default:
        return value;
    }
  }

  static List<AppDropdownItem<String>> localizedGenders(
    AppLocalizations l10n,
    String? current,
  ) {
    final items = [
      for (final value in _genderValues)
        AppDropdownItem<String>(value: value, label: genderLabel(l10n, value)),
    ];
    final value = current?.trim() ?? '';
    if (value.isEmpty || items.any((item) => item.value == value)) {
      return items;
    }
    return [
      AppDropdownItem<String>(value: value, label: genderLabel(l10n, value)),
      ...items,
    ];
  }

  static List<AppDropdownItem<String>> _toItems(List<String> values) => [
        for (final value in values)
          AppDropdownItem<String>(value: value, label: value),
      ];

  static List<AppDropdownItem<String>> _withValue(
    List<AppDropdownItem<String>> items,
    String? current,
  ) {
    final value = current?.trim() ?? '';
    if (value.isEmpty) return items;
    final exists = items.any((item) => item.value == value);
    if (exists) return items;
    return [
      AppDropdownItem<String>(value: value, label: value),
      ...items,
    ];
  }
}
