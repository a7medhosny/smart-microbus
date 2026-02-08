// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String welcomeUser(Object name) {
    return 'Welcome $name';
  }

  @override
  String get youDontHaveAccount => 'You don\'t have an account';

  @override
  String get loginToContinueToYourAccount => 'Log in to continue to your account';

  @override
  String get loginNow => 'Login now';
}
