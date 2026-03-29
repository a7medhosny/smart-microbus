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
  String get notInQueue => 'لديك رحلة جارية حالياً';

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

  @override
  String get currentTripStatus => 'حالة الرحلة الحالية';

  @override
  String get tripActiveNow => 'نشط الآن';

  @override
  String get tripStarted => 'بدأت الرحلة';

  @override
  String tripStartedSince(Object minutes) {
    return 'بدأت منذ $minutes دقيقة';
  }

  @override
  String get tripStartPoint => 'نقطة الانطلاق';

  @override
  String get tripDestination => 'جهة الوصول';

  @override
  String get tripDistance => 'المسافة';

  @override
  String get tripEstimatedTime => 'الوقت المتوقع';

  @override
  String get selectCity => 'اختر المدينة';

  @override
  String get currentLocationHint => 'مرحبًا بك في سمارت ميكروباص\nاختر نقطة الانطلاق لعرض الرحلات المتاحة حولك';

  @override
  String get selectDestination => 'اختر الوجهة';

  @override
  String get searchTrips => 'ابحث عن الرحلات';

  @override
  String get searchResults => 'نتائج البحث';

  @override
  String get availableAtStation => 'متوفر في المحطة';

  @override
  String get onTheWay => 'في الطريق';

  @override
  String get tapToViewDetails => 'اضغط لعرض التفاصيل';

  @override
  String get microbusesAtStation => 'ميكروباصات في المحطة';

  @override
  String get comingToYou => 'في الطريق إليك';

  @override
  String afterMinutes(Object minutes) {
    return 'بعد $minutes دقيقة';
  }

  @override
  String afterMinutes_one(Object minutes) {
    return 'بعد $minutes دقيقة';
  }

  @override
  String order(Object position) {
    return 'ترتيب $position';
  }

  @override
  String get statusLoading => 'جاري التحميل';

  @override
  String get statusReady => 'جاهز';

  @override
  String get statusWaiting => 'في الانتظار';

  @override
  String get statusBoarding => 'جاهز للركوب';

  @override
  String get statusNear => 'قريب';

  @override
  String get tripSummary => 'ملخص الرحلة';

  @override
  String priceInCurrency(Object price) {
    return '$price جنيه';
  }

  @override
  String get distance => 'المسافة';

  @override
  String distanceKm(Object distance) {
    return '$distance كم';
  }

  @override
  String get atStation => 'في المحطة';

  @override
  String get nearestArrival => 'أقرب وصول';

  @override
  String minutesShort(Object minutes) {
    return '$minutes د';
  }

  @override
  String get noMicrobuses => 'لا يوجد ميكروباصات';

  @override
  String get noMicrobusesDesc => 'حاول مرة أخرى لاحقًا أو غيّر الوجهة';

  @override
  String get plateNumber => 'رقم اللوحة';

  @override
  String get person => 'راكب';

  @override
  String get passengers => 'عدد الركاب';

  @override
  String get arrivalTime => 'موعد الوصول';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get pleaseSelectARoute => 'من فضلك اختر محطة القيام و محطة الوصول';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changePasswordDesc => 'أدخل كلمة المرور الجديدة وقم بتأكيدها';

  @override
  String get changeTheme => 'تغيير السمة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get passwordUpdated => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get logoutConfirmation => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get noDataTitle => 'لا توجد بيانات';

  @override
  String get noDataDescription => 'لا يوجد بيانات حالياً، حاول مرة أخرى';

  @override
  String get report_title => 'إبلاغ عن سائق';

  @override
  String get plate_number => 'رقم اللوحة';

  @override
  String get report_reason => 'سبب الإبلاغ';

  @override
  String get extra_details => 'تفاصيل إضافية';

  @override
  String get submit => 'إرسال البلاغ';

  @override
  String get required => 'من فضلك أكمل البيانات';

  @override
  String get other => 'اخري';

  @override
  String get favoritesTitle => 'المفضلة';

  @override
  String get noFavorites => 'لا توجد طرق مفضلة حتى الآن';

  @override
  String get routeLabel => 'الخط';

  @override
  String get priceLabel => 'السعر';

  @override
  String get reportTitle => 'الإبلاغ عن سائق';

  @override
  String get plateNumberLabel => 'رقم اللوحة';

  @override
  String get additionalDetailsHint => 'تفاصيل إضافية...';

  @override
  String get submitReport => 'إرسال البلاغ';

  @override
  String get selectReasonError => 'من فضلك اختر سبب البلاغ';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get home => 'الصفحة الرئيسية';

  @override
  String get noFavoritesMessage => 'ابدأ بإضافة طرقك المفضلة لتظهر هنا';

  @override
  String get errorHint => 'عذرًا!';

  @override
  String get roleNotSupportedMessage => 'هذا الدور غير مدعوم داخل التطبيق. يُرجى زيارة لوحة التحكم أو تجربة حساب آخر.';

  @override
  String get accountInformation => 'معلومات الحساب';

  @override
  String get actions => 'الإجراءات';

  @override
  String get more => 'المزيد';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountTitle => 'حذف الحساب؟';

  @override
  String get deleteAccountMessage => 'لا يمكن التراجع عن هذا الإجراء.\nهل أنت متأكد أنك تريد المتابعة؟';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get deletePhoto => 'حذف الصورة';

  @override
  String get editReportTitle => 'تعديل البلاغ';

  @override
  String get updateReport => 'تعديل البلاغ';

  @override
  String get reportDetails => 'تفاصيل البلاغ';

  @override
  String get status => 'الحالة';

  @override
  String get description => 'الوصف';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get deleteReport => 'حذف البلاغ';

  @override
  String get deleteConfirmation => 'هل أنت متأكد من حذف هذا البلاغ؟';

  @override
  String get reasons => 'الأسباب';

  @override
  String get enterDescriptionError => 'من فضلك اكتب السبب';
}
