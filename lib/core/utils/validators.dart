import 'package:todo_app/l10n/app_localizations.dart';

class Validators {
  static String? validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.emailIsRequired;
    }
    if (value.contains(' ')) {
      return l10n.emailContainsSpaces;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return l10n.invalidEmail;
    }
    return null;
  }

  static String? validateSignUpPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.passwordIsRequired;
    }
    if (value.length < 8) {
      return l10n.passwordTooShort8;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return l10n.passwordNoUppercase;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return l10n.passwordNoNumber;
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return l10n.passwordNoSpecialChar;
    }
    return null;
  }

  static String? validateSignInPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.passwordIsRequired;
    }
    if (value.length < 6) {
      return l10n.passwordTooShort6;
    }
    return null;
  }

  static String? validateName(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.fullNameIsRequired;
    }
    if (value.length < 3) {
      return l10n.nameTooShort3;
    }
    if (RegExp(r'^[0-9]+$').hasMatch(value)) {
      return l10n.nameOnlyNumbers;
    }
    return null;
  }
}
