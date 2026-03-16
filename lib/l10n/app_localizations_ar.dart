// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'SMART MICROBUS';

  @override
  String get welcomeToMinya => 'أهلاً بك في المنيا';

  @override
  String get chooseRoleDescription => 'يرجى اختيار دورك للبدء في استخدام نظام النقل الذكي';

  @override
  String get passenger => 'راكب';

  @override
  String get passengerDescription => 'ابحث عن رحلتك واحجز مقعدك بسهولة';

  @override
  String get driver => 'سائق';

  @override
  String get driverDescription => 'ابدأ رحلاتك واستقبل حجوزات الركاب';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get loginToContinue => 'سجل الدخول للمتابعة إلى حسابك';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get enterPhoneNumber => '01xxxxxxxxx';

  @override
  String get phoneRequired => 'من فضلك أدخل رقم الهاتف';

  @override
  String get phoneNotConfirmed => 'رقم الهاتف غير مُفعل. برجاء تأكيد حسابك قبل تسجيل الدخول.';

  @override
  String get otpSent => 'تم إرسال رمز التحقق إلى رقم هاتفك.';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordRequired => 'من فضلك أدخل كلمة المرور';

  @override
  String get passwordShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get passwordNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get passwordResetSuccess => 'تم إعادة تعيين كلمة المرور بنجاح.';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgetPasswordFormTitle => 'استعادة كلمة المرور';

  @override
  String get forgetPasswordFormDescription => 'أدخل رقم هاتفك لإرسال رمز التحقق.';

  @override
  String get sendResetCode => 'إرسال رمز التحقق';

  @override
  String get enterNewPasswordDesc => 'أدخل كلمة مرور جديدة لتأمين حسابك';

  @override
  String get sendCode => 'إرسال الكود';

  @override
  String get verifyCode => 'تأكيد الكود';

  @override
  String get enterOtpSentTo => 'أدخل الكود المرسل إلى';

  @override
  String get verify => 'تأكيد';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get registerNow => 'سجل الآن';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get registerToSmartMicrobus => 'انضم إلى خدمة الميكروباص الذكي بخطوات بسيطة';

  @override
  String get fullName => 'الاسم بالكامل';

  @override
  String get enterFullName => 'أدخل اسمك هنا';

  @override
  String get licenseNumber => 'رقم الرخصة';

  @override
  String get enterLicenseNumber => 'أدخل رقم الرخصة';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get loginNow => 'سجل دخول';

  @override
  String get verifyOtpTitle => 'تأكيد الكود';

  @override
  String get otpSentTo => 'تم إرسال الكود إلى';

  @override
  String get resendCode => 'إعادة إرسال الكود';

  @override
  String get accountConfirmed => 'تم تأكيد حسابك بنجاح، يمكنك الآن تسجيل الدخول';

  @override
  String get invalidPhone => 'رقم هاتف غير صالح';

  @override
  String get invalidPassword => 'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل وتشمل حرفًا كبيرًا وحرفًا صغيرًا ورقمًا.';

  @override
  String get licenseRequired => 'من فضلك أدخل رقم رخصة القيادة';

  @override
  String get invalidLicense => 'رقم رخصة القيادة غير صالح';

  @override
  String helloDriver(Object name) {
    return 'أهلاً $name';
  }

  @override
  String driverRoleVehicle(Object vehicle) {
    return 'السائق - مركبة $vehicle';
  }

  @override
  String vehicleNumber(Object number) {
    return 'مركبة $number';
  }

  @override
  String get currentStation => 'المحطة الحالية';

  @override
  String get online => 'متصل';

  @override
  String get offline => 'غير متصل';

  @override
  String get yourQueueTitle => 'ترتيبك في الطابور';

  @override
  String get waitingTime => 'وقت الانتظار';

  @override
  String get vehiclesAhead => 'مركبات أمامك';

  @override
  String get queueTitle => 'ترتيبك في الطابور';

  @override
  String get nextInQueue => 'القادم في الطابور';

  @override
  String get loadingPassengers => 'تحميل الركاب';

  @override
  String get inQueue => 'في انتظار';

  @override
  String get yourTurnSoon => 'دورك القادم قريباً';

  @override
  String get you => 'أنت';

  @override
  String get todayEarnings => 'أرباح اليوم';

  @override
  String get trips => 'رحلة';

  @override
  String get viewAllTrips => 'عرض جميع الرحلات';

  @override
  String get tripHistory => 'سجل الرحلات';

  @override
  String get noTripsYet => 'لا توجد رحلات حتى الآن';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get notInQueue => 'غير موجود في الكيو حالياً';

  @override
  String get driverNotInQueueTitle => 'أنت غير موجود في الطابور حالياً';

  @override
  String get driverNotInQueueDescription => 'يرجى عمل مسح (QR) عند المسؤول للانضمام إلى الطابور وبدء العمل.';

  @override
  String get tripsHistory => 'سجل الرحلات';

  @override
  String get egp => 'ج.م';

  @override
  String get completed => 'مكتملة';

  @override
  String get noTripsTitle => 'لا توجد رحلات';

  @override
  String get noTripsDescription => 'لا توجد رحلات في الفترة المحددة. حاول تغيير نطاق التاريخ.';

  @override
  String get yourTurnNotificationTitle => 'دورك الآن';

  @override
  String get yourTurnNotificationBody => 'حان دورك لتحميل الركاب في المحطة';
}
