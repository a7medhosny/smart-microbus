class ApiConstants {
  static const String baseUrl =
      'https://smart-microbus.runasp.net/api/v1';

  // =========================
  // Auth / Account Endpoints
  // =========================

  static const String registerDriverEndpoint =
      '/Account/register-driver';

  static const String registerPassengerEndpoint =
      '/Account/register-passanger';

  static const String loginEndpoint =
      '/Account/login';

  static const String forgotPasswordEndpoint =
      '/Account/forgot-password';

  static const String verifyOtpEndpoint =
      '/Account/verify-otp';
  static const String confirmAccountEndpoint =
      '/Account/confirm-account';
  static const String resendConfirmationEndpoint =
      '/Account/resend-confirmation';
      

  static const String resetPasswordEndpoint =
      '/Account/reset-password';

  static const String logoutEndpoint =
      '/Account/logout';

  static const String refreshTokenEndpoint =
      '/Account/generate-new-jwt-token';

  static const String uploadPhotoEndpoint =
      '/Account/upload-photo';

  static const String deletePhotoEndpoint =
      '/Account/delete-photo';

  static const String deleteAccountEndpoint =
      '/Account/delete';

  // =========================
  // Existing Endpoints
  // =========================

  static const String userProfileEndpoint =
      '/user/profile';

  static const String busRoutesEndpoint =
      '/bus/routes';

  static const String busLocationsEndpoint =
      '/bus/locations';
}
