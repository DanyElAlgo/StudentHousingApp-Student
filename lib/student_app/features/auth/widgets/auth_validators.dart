import 'package:student_lib/l10n/generated/app_localizations.dart';

abstract final class AuthValidators {
  AuthValidators._();

  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _phone = RegExp(r'^\d{7,15}$');

  static String? email(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.authValidatorEmailRequired;
    if (!_email.hasMatch(v)) return l10n.authValidatorEmailInvalid;
    return null;
  }

  static String? requiredField(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? phone(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.authValidatorPhoneRequired;
    if (!_phone.hasMatch(v)) return l10n.authValidatorPhoneInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final v = value ?? '';
    if (v.isEmpty) return l10n.authValidatorPasswordRequired;
    if (v.length < 8) return l10n.authValidatorPasswordMinLength;
    if (!RegExp(r'[A-Z]').hasMatch(v)) return l10n.authValidatorPasswordUppercase;
    if (!RegExp(r'[a-z]').hasMatch(v)) return l10n.authValidatorPasswordLowercase;
    if (!RegExp(r'\d').hasMatch(v)) return l10n.authValidatorPasswordNumber;
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(v)) {
      return l10n.authValidatorPasswordSpecial;
    }
    return null;
  }

  static String? loginPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.authValidatorLoginPasswordRequired;
    return null;
  }
}
