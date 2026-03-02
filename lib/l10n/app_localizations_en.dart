// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signIn => 'SIGN IN';

  @override
  String get signUp => 'SIGN UP';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get haveAnAccount => 'Have an account?';

  @override
  String get changePassword => 'CHANGE PASSWORD';

  @override
  String get emailIsRequired => 'Email is required';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get emailContainsSpaces => 'Email cannot contain spaces';

  @override
  String get passwordIsRequired => 'Password is required';

  @override
  String get passwordTooShort6 => 'Password must be at least 6 characters';

  @override
  String get passwordCannotBeEmpty => 'Password cannot be empty';

  @override
  String get passwordTooShort8 => 'Password must be at least 8 characters';

  @override
  String get passwordNoUppercase =>
      'Password must include at least one uppercase letter';

  @override
  String get passwordNoNumber => 'Password must include at least one number';

  @override
  String get passwordNoSpecialChar =>
      'Password must include at least one special character';

  @override
  String get confirmPasswordIsRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get fullNameIsRequired => 'Full name is required';

  @override
  String get nameTooShort3 => 'Name must be at least 3 characters';

  @override
  String get nameOnlyNumbers => 'Name cannot contain numbers only';
}
