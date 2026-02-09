import '../models/auth_response_model.dart';
import '../models/register_driver_request_model.dart';
import '../models/register_passenger_request_model.dart';
import '../models/verify_otp_request_model.dart';

abstract class RegisterRemoteDataSource {
  Future<AuthResponseModel> registerDriver(
    RegisterDriverRequestModel model,
  );

  Future<AuthResponseModel> registerPassenger(
    RegisterPassengerRequestModel model,
  );

  Future<void> verifyOtp(
    VerifyOtpRequestModel model,
  );
}
