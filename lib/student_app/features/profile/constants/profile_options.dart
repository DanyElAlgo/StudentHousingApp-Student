import 'package:housing_design_system/housing_design_system.dart';

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

  static List<AppDropdownItem<String>> get genders =>
      _toItems(_genderValues);

  static List<AppDropdownItem<String>> get nationalities =>
      _toItems(_nationalityValues);

  static List<AppDropdownItem<String>> gendersWith(String? current) =>
      _withValue(genders, current);

  static List<AppDropdownItem<String>> nationalitiesWith(String? current) =>
      _withValue(nationalities, current);

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
