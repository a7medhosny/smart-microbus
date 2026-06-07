import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Wasla'**
  String get appName;

  /// No description provided for @welcomeToMinya.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Minya'**
  String get welcomeToMinya;

  /// No description provided for @chooseRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Smart transportation starts here. Track, ride, and travel smarter'**
  String get chooseRoleDescription;

  /// No description provided for @smart_transport_platform.
  ///
  /// In en, this message translates to:
  /// **'Smart Transport Platform'**
  String get smart_transport_platform;

  /// No description provided for @passenger.
  ///
  /// In en, this message translates to:
  /// **'Passenger'**
  String get passenger;

  /// No description provided for @passengerDescription.
  ///
  /// In en, this message translates to:
  /// **'Search for your trip and book your seat easily'**
  String get passengerDescription;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @driverDescription.
  ///
  /// In en, this message translates to:
  /// **'Start your trips and receive passenger bookings'**
  String get driverDescription;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue to your account'**
  String get loginToContinue;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'01xxxxxxxxx'**
  String get enterPhoneNumber;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneRequired;

  /// No description provided for @phoneNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Phone number not confirmed. Please confirm your account before logging in.'**
  String get phoneNotConfirmed;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'A verification code has been sent to your phone number.'**
  String get otpSent;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// No description provided for @passwordShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordShort;

  /// No description provided for @passwordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordNotMatch;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully.'**
  String get passwordResetSuccess;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgetPasswordFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgetPasswordFormTitle;

  /// No description provided for @forgetPasswordFormDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to receive a verification code.'**
  String get forgetPasswordFormDescription;

  /// No description provided for @sendResetCode.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get sendResetCode;

  /// No description provided for @enterNewPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password to secure your account'**
  String get enterNewPasswordDesc;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyCode;

  /// No description provided for @enterOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to'**
  String get enterOtpSentTo;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @registerToSmartMicrobus.
  ///
  /// In en, this message translates to:
  /// **'Join Smart Microbus in simple steps'**
  String get registerToSmartMicrobus;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name here'**
  String get enterFullName;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get licenseNumber;

  /// No description provided for @enterLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter license'**
  String get enterLicenseNumber;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginNow;

  /// No description provided for @verifyOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyOtpTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Code sent to'**
  String get otpSentTo;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @accountConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your account has been confirmed successfully. You can now log in.'**
  String get accountConfirmed;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhone;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters and include an uppercase letter, a lowercase letter, and a number.'**
  String get invalidPassword;

  /// No description provided for @licenseRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your driving license number'**
  String get licenseRequired;

  /// No description provided for @invalidLicense.
  ///
  /// In en, this message translates to:
  /// **'Invalid driving license number'**
  String get invalidLicense;

  /// No description provided for @helloDriver.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}'**
  String helloDriver(Object name);

  /// No description provided for @driverRoleVehicle.
  ///
  /// In en, this message translates to:
  /// **'Driver - Vehicle {vehicle}'**
  String driverRoleVehicle(Object vehicle);

  /// No description provided for @vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle {number}'**
  String vehicleNumber(Object number);

  /// No description provided for @currentStation.
  ///
  /// In en, this message translates to:
  /// **'Current Station'**
  String get currentStation;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @yourQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Queue Position'**
  String get yourQueueTitle;

  /// No description provided for @waitingTime.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time'**
  String get waitingTime;

  /// No description provided for @vehiclesAhead.
  ///
  /// In en, this message translates to:
  /// **'Vehicles Ahead'**
  String get vehiclesAhead;

  /// No description provided for @queueTitle.
  ///
  /// In en, this message translates to:
  /// **'Your queue position'**
  String get queueTitle;

  /// No description provided for @nextInQueue.
  ///
  /// In en, this message translates to:
  /// **'Next in queue'**
  String get nextInQueue;

  /// No description provided for @loadingPassengers.
  ///
  /// In en, this message translates to:
  /// **'Loading passengers'**
  String get loadingPassengers;

  /// No description provided for @inQueue.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get inQueue;

  /// No description provided for @yourTurnSoon.
  ///
  /// In en, this message translates to:
  /// **'Your turn is soon'**
  String get yourTurnSoon;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @todayEarnings.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Earnings'**
  String get todayEarnings;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @viewAllTrips.
  ///
  /// In en, this message translates to:
  /// **'View All Trips'**
  String get viewAllTrips;

  /// No description provided for @tripHistory.
  ///
  /// In en, this message translates to:
  /// **'Trip History'**
  String get tripHistory;

  /// No description provided for @noTripsYet.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get noTripsYet;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @notInQueue.
  ///
  /// In en, this message translates to:
  /// **'You have an ongoing trip'**
  String get notInQueue;

  /// No description provided for @driverNotInQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'You are not currently in the queue'**
  String get driverNotInQueueTitle;

  /// No description provided for @driverNotInQueueDescription.
  ///
  /// In en, this message translates to:
  /// **'Please ask the admin to scan your QR code to join the queue and start working.'**
  String get driverNotInQueueDescription;

  /// No description provided for @tripsHistory.
  ///
  /// In en, this message translates to:
  /// **'Trip History'**
  String get tripsHistory;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @noTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'No trips found'**
  String get noTripsTitle;

  /// No description provided for @noTripsDescription.
  ///
  /// In en, this message translates to:
  /// **'There are no trips for the selected period. Try changing the date range.'**
  String get noTripsDescription;

  /// No description provided for @yourTurnNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'It\'s your turn'**
  String get yourTurnNotificationTitle;

  /// No description provided for @yourTurnNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You can now start loading passengers at the station'**
  String get yourTurnNotificationBody;

  /// No description provided for @currentTripStatus.
  ///
  /// In en, this message translates to:
  /// **'Current Trip Status'**
  String get currentTripStatus;

  /// No description provided for @tripActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active Now'**
  String get tripActiveNow;

  /// No description provided for @tripStarted.
  ///
  /// In en, this message translates to:
  /// **'Trip Started'**
  String get tripStarted;

  /// No description provided for @tripStartedSince.
  ///
  /// In en, this message translates to:
  /// **'Started {minutes} minutes ago'**
  String tripStartedSince(Object minutes);

  /// No description provided for @tripStartPoint.
  ///
  /// In en, this message translates to:
  /// **'Start Point'**
  String get tripStartPoint;

  /// No description provided for @tripDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get tripDestination;

  /// No description provided for @tripDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get tripDistance;

  /// No description provided for @tripEstimatedTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated Time'**
  String get tripEstimatedTime;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select city'**
  String get selectCity;

  /// No description provided for @currentLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Wasla\nChoose your starting point to find available trips around you'**
  String get currentLocationHint;

  /// No description provided for @selectDestination.
  ///
  /// In en, this message translates to:
  /// **'Select destination'**
  String get selectDestination;

  /// No description provided for @searchTrips.
  ///
  /// In en, this message translates to:
  /// **'Search Trips'**
  String get searchTrips;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @availableAtStation.
  ///
  /// In en, this message translates to:
  /// **'Available at Station'**
  String get availableAtStation;

  /// No description provided for @onTheWay.
  ///
  /// In en, this message translates to:
  /// **'On The Way'**
  String get onTheWay;

  /// No description provided for @tapToViewDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap to view details'**
  String get tapToViewDetails;

  /// No description provided for @microbusesAtStation.
  ///
  /// In en, this message translates to:
  /// **'Microbuses at station'**
  String get microbusesAtStation;

  /// No description provided for @comingToYou.
  ///
  /// In en, this message translates to:
  /// **'Coming to you'**
  String get comingToYou;

  /// No description provided for @afterMinutes.
  ///
  /// In en, this message translates to:
  /// **'After {minutes} minutes'**
  String afterMinutes(Object minutes);

  /// No description provided for @afterMinutes_one.
  ///
  /// In en, this message translates to:
  /// **'After {minutes} minute'**
  String afterMinutes_one(Object minutes);

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order {position}'**
  String order(Object position);

  /// No description provided for @statusLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get statusLoading;

  /// No description provided for @statusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get statusReady;

  /// No description provided for @statusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get statusWaiting;

  /// No description provided for @statusBoarding.
  ///
  /// In en, this message translates to:
  /// **'Ready to board'**
  String get statusBoarding;

  /// No description provided for @statusNear.
  ///
  /// In en, this message translates to:
  /// **' Nearest'**
  String get statusNear;

  /// No description provided for @tripSummary.
  ///
  /// In en, this message translates to:
  /// **'Trip Summary'**
  String get tripSummary;

  /// No description provided for @priceInCurrency.
  ///
  /// In en, this message translates to:
  /// **'{price} EGP'**
  String priceInCurrency(Object price);

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKm(Object distance);

  /// No description provided for @atStation.
  ///
  /// In en, this message translates to:
  /// **'At Station'**
  String get atStation;

  /// No description provided for @nearestArrival.
  ///
  /// In en, this message translates to:
  /// **'Nearest Arrival'**
  String get nearestArrival;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(Object minutes);

  /// No description provided for @noMicrobuses.
  ///
  /// In en, this message translates to:
  /// **'No microbuses available'**
  String get noMicrobuses;

  /// No description provided for @noMicrobusesDesc.
  ///
  /// In en, this message translates to:
  /// **'Try again later or change your destination'**
  String get noMicrobusesDesc;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumber;

  /// No description provided for @person.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get person;

  /// No description provided for @passengers.
  ///
  /// In en, this message translates to:
  /// **'Passenger'**
  String get passengers;

  /// No description provided for @arrivalTime.
  ///
  /// In en, this message translates to:
  /// **'Arrival Time'**
  String get arrivalTime;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @pleaseSelectARoute.
  ///
  /// In en, this message translates to:
  /// **'Please Select A Route'**
  String get pleaseSelectARoute;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password and confirm it'**
  String get changePasswordDesc;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passwordUpdated;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @noDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get noDataTitle;

  /// No description provided for @noDataDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn’t find any data right now. Please try again.'**
  String get noDataDescription;

  /// No description provided for @report_title.
  ///
  /// In en, this message translates to:
  /// **'Report Driver'**
  String get report_title;

  /// No description provided for @plate_number.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plate_number;

  /// No description provided for @report_reason.
  ///
  /// In en, this message translates to:
  /// **'Report Reason'**
  String get report_reason;

  /// No description provided for @extra_details.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get extra_details;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submit;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get required;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite routes yet'**
  String get noFavorites;

  /// No description provided for @routeLabel.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get routeLabel;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Driver'**
  String get reportTitle;

  /// No description provided for @plateNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumberLabel;

  /// No description provided for @additionalDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Additional details...'**
  String get additionalDetailsHint;

  /// No description provided for @submitReport.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// No description provided for @selectReasonError.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason'**
  String get selectReasonError;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @noFavoritesMessage.
  ///
  /// In en, this message translates to:
  /// **'Start adding your favorite routes to see them here'**
  String get noFavoritesMessage;

  /// No description provided for @errorHint.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get errorHint;

  /// No description provided for @roleNotSupportedMessage.
  ///
  /// In en, this message translates to:
  /// **'This role is not supported in the application. Please visit the dashboard or try another account.'**
  String get roleNotSupportedMessage;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.\nAre you sure you want to continue?'**
  String get deleteAccountMessage;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @deletePhoto.
  ///
  /// In en, this message translates to:
  /// **'Delete Photo'**
  String get deletePhoto;

  /// No description provided for @editReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Report'**
  String get editReportTitle;

  /// No description provided for @updateReport.
  ///
  /// In en, this message translates to:
  /// **'Updated Report'**
  String get updateReport;

  /// No description provided for @reportDetails.
  ///
  /// In en, this message translates to:
  /// **'Report Details'**
  String get reportDetails;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @deleteReport.
  ///
  /// In en, this message translates to:
  /// **'Delete Report'**
  String get deleteReport;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this report?'**
  String get deleteConfirmation;

  /// No description provided for @reasons.
  ///
  /// In en, this message translates to:
  /// **'Reasons'**
  String get reasons;

  /// No description provided for @enterDescriptionError.
  ///
  /// In en, this message translates to:
  /// **'Please enter the reason'**
  String get enterDescriptionError;

  /// No description provided for @reports_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No Reports Yet'**
  String get reports_empty_title;

  /// No description provided for @reports_empty_message.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t submitted any reports yet. Once you do, they will appear here.'**
  String get reports_empty_message;

  /// No description provided for @all_reports_title.
  ///
  /// In en, this message translates to:
  /// **'All Reports'**
  String get all_reports_title;

  /// No description provided for @filter_reports.
  ///
  /// In en, this message translates to:
  /// **'Filter Reports'**
  String get filter_reports;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @already_reported.
  ///
  /// In en, this message translates to:
  /// **'Already Reported'**
  String get already_reported;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search for a station'**
  String get searchHere;

  /// No description provided for @nearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest Station'**
  String get nearest;

  /// No description provided for @chooseStations.
  ///
  /// In en, this message translates to:
  /// **'Select stations to view the route'**
  String get chooseStations;

  /// No description provided for @selectStationToViewDetails.
  ///
  /// In en, this message translates to:
  /// **'Select a station to view details'**
  String get selectStationToViewDetails;

  /// No description provided for @routeInformationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Route information is unavailable'**
  String get routeInformationUnavailable;

  /// No description provided for @startAndEndCannotBeSame.
  ///
  /// In en, this message translates to:
  /// **'Start and destination stations cannot be the same'**
  String get startAndEndCannotBeSame;

  /// No description provided for @stations.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get stations;

  /// No description provided for @noStationsFound.
  ///
  /// In en, this message translates to:
  /// **'No stations found for your search'**
  String get noStationsFound;

  /// No description provided for @liveTracking.
  ///
  /// In en, this message translates to:
  /// **'Live Bus Tracking'**
  String get liveTracking;

  /// No description provided for @noLiveLocationAvailable.
  ///
  /// In en, this message translates to:
  /// **'Live location is currently unavailable'**
  String get noLiveLocationAvailable;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Estimated Time'**
  String get duration;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get updated;

  /// No description provided for @loadingTracking.
  ///
  /// In en, this message translates to:
  /// **'Loading live tracking...'**
  String get loadingTracking;

  /// No description provided for @distance_km.
  ///
  /// In en, this message translates to:
  /// **'{value} km'**
  String distance_km(Object value);

  /// No description provided for @continue_as_guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as a Guest'**
  String get continue_as_guest;

  /// No description provided for @duration_min.
  ///
  /// In en, this message translates to:
  /// **'{value} min'**
  String duration_min(Object value);

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Smart Tracking'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Real-time microbus tracking with GPS technology. Know exactly where your bus is at every moment.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Smart Routes'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Optimized routes and intelligent navigation. Get to your destination faster and smarter.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Faster Daily Commute'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Save time and move smarter every day. Experience the future of urban transportation.'**
  String get onboardingSubtitle3;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @join_us.
  ///
  /// In en, this message translates to:
  /// **'Unlock Full Experience'**
  String get join_us;

  /// No description provided for @guest_banner_desc.
  ///
  /// In en, this message translates to:
  /// **'Create an account or sign in to access personalized features, saved items, reports, and real-time updates.'**
  String get guest_banner_desc;

  /// No description provided for @login_required.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get login_required;

  /// No description provided for @guest_access_message.
  ///
  /// In en, this message translates to:
  /// **'Create an account or sign in to access this feature'**
  String get guest_access_message;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @guest_profile_message.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save your preferences and access all features.'**
  String get guest_profile_message;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get profile_title;

  /// No description provided for @liveQueue.
  ///
  /// In en, this message translates to:
  /// **'LIVE QUEUE'**
  String get liveQueue;

  /// No description provided for @realtimeStationUpdates.
  ///
  /// In en, this message translates to:
  /// **'Realtime station updates'**
  String get realtimeStationUpdates;

  /// No description provided for @driversCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Drivers'**
  String driversCount(Object count);

  /// No description provided for @noDriversInQueue.
  ///
  /// In en, this message translates to:
  /// **'No drivers in queue'**
  String get noDriversInQueue;

  /// No description provided for @waitingDriversQueue.
  ///
  /// In en, this message translates to:
  /// **'Waiting for drivers to join the station queue.'**
  String get waitingDriversQueue;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @busGateScanner.
  ///
  /// In en, this message translates to:
  /// **'Bus Gate Scanner'**
  String get busGateScanner;

  /// No description provided for @readyForScanning.
  ///
  /// In en, this message translates to:
  /// **'Ready for QR scanning'**
  String get readyForScanning;

  /// No description provided for @busEntry.
  ///
  /// In en, this message translates to:
  /// **'Microbus Entry'**
  String get busEntry;

  /// No description provided for @busExit.
  ///
  /// In en, this message translates to:
  /// **'Microbus Exit'**
  String get busExit;

  /// No description provided for @allowBusEntry.
  ///
  /// In en, this message translates to:
  /// **'Allow Microbus to enter station'**
  String get allowBusEntry;

  /// No description provided for @registerBusExit.
  ///
  /// In en, this message translates to:
  /// **'Register Microbus exit'**
  String get registerBusExit;

  /// No description provided for @tapToScan.
  ///
  /// In en, this message translates to:
  /// **'Tap to scan'**
  String get tapToScan;

  /// No description provided for @scanInstruction.
  ///
  /// In en, this message translates to:
  /// **'Point the camera toward the Microbus QR code'**
  String get scanInstruction;

  /// No description provided for @scannerStatus.
  ///
  /// In en, this message translates to:
  /// **'Scanner Status'**
  String get scannerStatus;

  /// No description provided for @placeQrInsideFrame.
  ///
  /// In en, this message translates to:
  /// **'Place QR code inside the frame'**
  String get placeQrInsideFrame;

  /// No description provided for @systemReadyForScanning.
  ///
  /// In en, this message translates to:
  /// **'System ready for Microbus QR scanning'**
  String get systemReadyForScanning;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
