import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/register_driver_request.dart';
import '../../domain/entities/register_passenger_request.dart';
import '../../domain/entities/verify_otp_request.dart';
import '../../domain/repositories/register_repoistory.dart';

import '../datasource/register_remote_data_source.dart';
import '../models/register_driver_request_model.dart';
import '../models/register_passenger_request_model.dart';
import '../models/verify_otp_request_model.dart';

class RegisterRepositoryImpl
    implements RegisterRepoistory {
  final RegisterRemoteDataSource remoteDataSource;
String defaultErrorMessage = 'Please try again later.';
  RegisterRepositoryImpl(this.remoteDataSource);

  // ---------------- DRIVER ----------------

  @override
  Future<Either<Failure, AuthResponse>>
      registerDriver(
    RegisterDriverRequest request,
  ) async {
    try {
      final model =
          RegisterDriverRequestModel(
        displayName: request.displayName,
        phoneNumber: request.phoneNumber,
        password: request.password,
        licenseNumber: request.licenseNumber,
      );

      final response =
          await remoteDataSource
              .registerDriver(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(
        ServerFailure(defaultErrorMessage),
      );
    }
  }

  // ---------------- PASSENGER ----------------

  @override
  Future<Either<Failure, AuthResponse>>
      registerPassenger(
    RegisterPassengerRequest request,
  ) async {
    try {
      final model =
          RegisterPassengerRequestModel(
        name: request.name,
        phoneNumber: request.phoneNumber,
        password: request.password,
      );

      final response =
          await remoteDataSource
              .registerPassenger(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(
        ServerFailure(defaultErrorMessage),
      );
    }
  }

  // ---------------- VERIFY OTP ----------------

  @override
  Future<Either<Failure, void>> verifyOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      final model = VerifyOtpRequestModel(
        phoneNumber: request.phoneNumber,
        otp: request.otp,
      );

      await remoteDataSource.verifyOtp(
        model,
      );

      return const Right(null);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(
        ServerFailure(defaultErrorMessage),
      );
    }
  }
}
