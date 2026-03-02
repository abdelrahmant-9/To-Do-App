// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get haveAnAccount => 'لديك حساب بالفعل؟';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get emailIsRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get invalidEmail => 'من فضلك أدخل بريد إلكتروني صحيح';

  @override
  String get emailContainsSpaces =>
      'البريد الإلكتروني لا يجب أن يحتوي على مسافات';

  @override
  String get passwordIsRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordTooShort6 => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get passwordCannotBeEmpty => 'كلمة المرور غير صالحة';

  @override
  String get passwordTooShort8 => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get passwordNoUppercase => 'يجب أن تحتوي كلمة المرور على حرف كبير';

  @override
  String get passwordNoNumber => 'يجب أن تحتوي كلمة المرور على رقم';

  @override
  String get passwordNoSpecialChar => 'يجب أن تحتوي كلمة المرور على رمز خاص';

  @override
  String get confirmPasswordIsRequired => 'من فضلك أكد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get fullNameIsRequired => 'الاسم بالكامل مطلوب';

  @override
  String get nameTooShort3 => 'الاسم يجب أن يكون 3 أحرف على الأقل';

  @override
  String get nameOnlyNumbers => 'الاسم لا يمكن أن يحتوي على أرقام فقط';
}
