import 'package:smart_microbus/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_response.dart';
import '../entities/register_driver_request.dart';
import '../entities/register_passenger_request.dart';
import '../entities/verify_otp_request.dart';

abstract class RegisterRepository {
  Future<Either<Failure, AuthResponse>> registerDriver(
    RegisterDriverRequest request,
  );
  Future<Either<Failure, AuthResponse>> registerPassenger(
    RegisterPassengerRequest request,
  );
  Future<Either<Failure, void>> verifyOtp(VerifyOtpRequest request);
}
