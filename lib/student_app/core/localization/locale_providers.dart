import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_providers.dart' show databaseProvider;
import '../database/app_database.dart';

/// Locales the app ships translations for. English is first so it acts as the
/// fallback when the device locale is not supported.
const List<Locale> kSupportedLocales = [
  Locale('en'),
  Locale('es'),
  Locale('pt'),
];

final localeControllerProvider =
    NotifierProvider<LocaleController, Locale?>(LocaleController.new);

class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() {
    _load();
    return null;
  }

  AppDatabase get _db => ref.read(databaseProvider);

  Future<void> _load() async {
    final code = await _db.readLanguageCode();
    if (code != null && code.isNotEmpty) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _db.saveLanguageCode(locale.languageCode);
  }
}
