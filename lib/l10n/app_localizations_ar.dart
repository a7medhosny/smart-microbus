// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String welcomeUser(Object name) {
    return 'مرحبا $name';
  }

  @override
  String get youDontHaveAccount => 'ليس لديك حساب';

  @override
  String get loginToContinueToYourAccount => 'ِسجل دخول للمتابعة الي حسابك';
}
