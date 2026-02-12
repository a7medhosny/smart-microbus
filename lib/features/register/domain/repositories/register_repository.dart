import 'package:smart_microbus/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_response.dart';
import '../entities/confirm_account_request.dart';
import '../entities/register_driver_request.dart';
import '../entities/register_passenger_request.dart';
import '../entities/resend_confirmation_request.dart';
import '../entities/verify_otp_request.dart';
import '../entities/verify_otp_response_entity.dart';

abstract class RegisterRepository {
  Future<Either<Failure, AuthResponse>> registerDriver(
    RegisterDriverRequest request,
  );
  Future<Either<Failure, AuthResponse>> registerPassenger(
    RegisterPassengerRequest request,
  );
  Future<Either<Failure, VerifyOtpResponseEntity>> verifyOtp(VerifyOtpRequest request);
  Future<Either<Failure, AuthResponse>> confirmAccount(ConfirmAccountRequest request);
  Future<Either<Failure, AuthResponse>> resendConfirmation(ResendConfirmationRequest request);

}
