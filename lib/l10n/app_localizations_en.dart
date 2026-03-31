// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SMART MICROBUS';

  @override
  String get welcomeToMinya => 'Welcome to Minya';

  @override
  String get chooseRoleDescription => 'Please choose your role to start using the smart transport system';

  @override
  String get passenger => 'Passenger';

  @override
  String get passengerDescription => 'Search for your trip and book your seat easily';

  @override
  String get driver => 'Driver';

  @override
  String get driverDescription => 'Start your trips and receive passenger bookings';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginToContinue => 'Log in to continue to your account';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get enterPhoneNumber => '01xxxxxxxxx';

  @override
  String get phoneRequired => 'Please enter your phone number';

  @override
  String get phoneNotConfirmed => 'Phone number not confirmed. Please confirm your account before logging in.';

  @override
  String get otpSent => 'A verification code has been sent to your phone number.';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordShort => 'Password must be at least 6 characters';

  @override
  String get passwordNotMatch => 'Passwords do not match';

  @override
  String get passwordResetSuccess => 'Your password has been reset successfully.';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get forgetPasswordFormTitle => 'Forgot Password';

  @override
  String get forgetPasswordFormDescription => 'Enter your phone number to receive a verification code.';

  @override
  String get sendResetCode => 'Send verification code';

  @override
  String get enterNewPasswordDesc => 'Enter a new password to secure your account';

  @override
  String get sendCode => 'Send code';

  @override
  String get verifyCode => 'Verify code';

  @override
  String get enterOtpSentTo => 'Enter the code sent to';

  @override
  String get verify => 'Verify';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get login => 'Login';

  @override
  String get loginSuccess => 'Logged in successfully';

  @override
  String get dontHaveAccount => 'Don’t have an account?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get createNewAccount => 'Create New Account';

  @override
  String get registerToSmartMicrobus => 'Join Smart Microbus in simple steps';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterFullName => 'Enter your name here';

  @override
  String get licenseNumber => 'License Number';

  @override
  String get enterLicenseNumber => 'Enter license';

  @override
  String get register => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Log in';

  @override
  String get verifyOtpTitle => 'Verify Code';

  @override
  String get otpSentTo => 'Code sent to';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get accountConfirmed => 'Your account has been confirmed successfully. You can now log in.';

  @override
  String get invalidPhone => 'Invalid phone number';

  @override
  String get invalidPassword => 'Password must be at least 8 characters and include an uppercase letter, a lowercase letter, and a number.';

  @override
  String get licenseRequired => 'Please enter your driving license number';

  @override
  String get invalidLicense => 'Invalid driving license number';

  @override
  String helloDriver(Object name) {
    return 'Hello $name';
  }

  @override
  String driverRoleVehicle(Object vehicle) {
    return 'Driver - Vehicle $vehicle';
  }

  @override
  String vehicleNumber(Object number) {
    return 'Vehicle $number';
  }

  @override
  String get currentStation => 'Current Station';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get yourQueueTitle => 'Your Queue Position';

  @override
  String get waitingTime => 'Waiting Time';

  @override
  String get vehiclesAhead => 'Vehicles Ahead';

  @override
  String get queueTitle => 'Your queue position';

  @override
  String get nextInQueue => 'Next in queue';

  @override
  String get loadingPassengers => 'Loading passengers';

  @override
  String get inQueue => 'Waiting';

  @override
  String get yourTurnSoon => 'Your turn is soon';

  @override
  String get you => 'You';

  @override
  String get todayEarnings => 'Today\'s Earnings';

  @override
  String get trips => 'Trips';

  @override
  String get viewAllTrips => 'View All Trips';

  @override
  String get tripHistory => 'Trip History';

  @override
  String get noTripsYet => 'No trips yet';

  @override
  String get loading => 'Loading...';

  @override
  String get notInQueue => 'You have an ongoing trip';

  @override
  String get driverNotInQueueTitle => 'You are not currently in the queue';

  @override
  String get driverNotInQueueDescription => 'Please ask the admin to scan your QR code to join the queue and start working.';

  @override
  String get tripsHistory => 'Trip History';

  @override
  String get egp => 'EGP';

  @override
  String get completed => 'Completed';

  @override
  String get noTripsTitle => 'No trips found';

  @override
  String get noTripsDescription => 'There are no trips for the selected period. Try changing the date range.';

  @override
  String get yourTurnNotificationTitle => 'It\'s your turn';

  @override
  String get yourTurnNotificationBody => 'You can now start loading passengers at the station';

  @override
  String get currentTripStatus => 'Current Trip Status';

  @override
  String get tripActiveNow => 'Active Now';

  @override
  String get tripStarted => 'Trip Started';

  @override
  String tripStartedSince(Object minutes) {
    return 'Started $minutes minutes ago';
  }

  @override
  String get tripStartPoint => 'Start Point';

  @override
  String get tripDestination => 'Destination';

  @override
  String get tripDistance => 'Distance';

  @override
  String get tripEstimatedTime => 'Estimated Time';

  @override
  String get selectCity => 'Select city';

  @override
  String get currentLocationHint => 'Welcome to Smart Microbus\nChoose your starting point to find available trips around you';

  @override
  String get selectDestination => 'Select destination';

  @override
  String get searchTrips => 'Search Trips';

  @override
  String get searchResults => 'Search Results';

  @override
  String get availableAtStation => 'Available at Station';

  @override
  String get onTheWay => 'On The Way';

  @override
  String get tapToViewDetails => 'Tap to view details';

  @override
  String get microbusesAtStation => 'Microbuses at station';

  @override
  String get comingToYou => 'Coming to you';

  @override
  String afterMinutes(Object minutes) {
    return 'After $minutes minutes';
  }

  @override
  String afterMinutes_one(Object minutes) {
    return 'After $minutes minute';
  }

  @override
  String order(Object position) {
    return 'Order $position';
  }

  @override
  String get statusLoading => 'Loading';

  @override
  String get statusReady => 'Ready';

  @override
  String get statusWaiting => 'Waiting';

  @override
  String get statusBoarding => 'Ready to board';

  @override
  String get statusNear => ' Nearest';

  @override
  String get tripSummary => 'Trip Summary';

  @override
  String priceInCurrency(Object price) {
    return '$price EGP';
  }

  @override
  String get distance => 'Dis tance';

  @override
  String distanceKm(Object distance) {
    return '$distance km';
  }

  @override
  String get atStation => 'At Station';

  @override
  String get nearestArrival => 'Nearest Arrival';

  @override
  String minutesShort(Object minutes) {
    return '$minutes min';
  }

  @override
  String get noMicrobuses => 'No microbuses available';

  @override
  String get noMicrobusesDesc => 'Try again later or change your destination';

  @override
  String get plateNumber => 'Plate Number';

  @override
  String get person => 'Person';

  @override
  String get passengers => 'Passenger';

  @override
  String get arrivalTime => 'Arrival Time';

  @override
  String get retry => 'Retry';

  @override
  String get pleaseSelectARoute => 'Please Select A Route';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordDesc => 'Enter your new password and confirm it';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get passwordUpdated => 'Password updated successfully';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get noDataTitle => 'No Data Available';

  @override
  String get noDataDescription => 'We couldn’t find any data right now. Please try again.';

  @override
  String get report_title => 'Report Driver';

  @override
  String get plate_number => 'Plate Number';

  @override
  String get report_reason => 'Report Reason';

  @override
  String get extra_details => 'Additional Details';

  @override
  String get submit => 'Submit Report';

  @override
  String get required => 'Please fill all required fields';

  @override
  String get other => 'Other';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get noFavorites => 'No favorite routes yet';

  @override
  String get routeLabel => 'Route';

  @override
  String get priceLabel => 'Price';

  @override
  String get reportTitle => 'Report Driver';

  @override
  String get plateNumberLabel => 'Plate Number';

  @override
  String get additionalDetailsHint => 'Additional details...';

  @override
  String get submitReport => 'Submit Report';

  @override
  String get selectReasonError => 'Please select a reason';

  @override
  String get seeAll => 'See all';

  @override
  String get home => 'Home';

  @override
  String get noFavoritesMessage => 'Start adding your favorite routes to see them here';

  @override
  String get errorHint => 'Oops!';

  @override
  String get roleNotSupportedMessage => 'This role is not supported in the application. Please visit the dashboard or try another account.';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get actions => 'Actions';

  @override
  String get more => 'More';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountTitle => 'Delete Account?';

  @override
  String get deleteAccountMessage => 'This action cannot be undone.\nAre you sure you want to continue?';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get deletePhoto => 'Delete Photo';

  @override
  String get editReportTitle => 'Edit Report';

  @override
  String get updateReport => 'Updated Report';

  @override
  String get reportDetails => 'Report Details';

  @override
  String get status => 'Status';

  @override
  String get description => 'Description';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get deleteReport => 'Delete Report';

  @override
  String get deleteConfirmation => 'Are you sure you want to delete this report?';

  @override
  String get reasons => 'Reasons';

  @override
  String get enterDescriptionError => 'Please enter the reason';

  @override
  String get reports_empty_title => 'No Reports Yet';

  @override
  String get reports_empty_message => 'You haven\'t submitted any reports yet. Once you do, they will appear here.';

  @override
  String get all_reports_title => 'All Reports';

  @override
  String get filter_reports => 'Filter Reports';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get apply => 'Apply';

  @override
  String get reset => 'Reset';

  @override
  String get reports => 'Reports';
}
