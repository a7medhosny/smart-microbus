import '../models/auth_response_model.dart';
import '../models/confirm_account_request_model.dart';
import '../models/register_driver_request_model.dart';
import '../models/register_passenger_request_model.dart';
import '../models/resend_confirmation_request_model.dart';
import '../models/verify_otp_request_model.dart';
import '../models/verify_otp_response_model.dart';

abstract class RegisterRemoteDataSource {
  Future<AuthResponseModel> registerDriver(
    RegisterDriverRequestModel model,
  );

  Future<AuthResponseModel> registerPassenger(
    RegisterPassengerRequestModel model,
  );

  Future<VerifyOtpResponseModel> verifyOtp(
    VerifyOtpRequestModel model,
  );

  Future<AuthResponseModel> confirmAccount(
    ConfirmAccountRequestModel model,
  );

  Future<AuthResponseModel> resendConfirmation(
    ResendConfirmationRequestModel model,
  );
}
