import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/features/register/domain/entities/confirm_account_request.dart';
import 'package:smart_microbus/features/register/domain/entities/resend_confirmation_request.dart';
import 'package:smart_microbus/features/register/domain/entities/verify_otp_response_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/register_driver_request.dart';
import '../../domain/entities/register_passenger_request.dart';
import '../../domain/entities/verify_otp_request.dart';
import '../../domain/repositories/register_repository.dart';

import '../datasource/register_remote_data_source.dart';
import '../models/confirm_account_request_model.dart';
import '../models/register_driver_request_model.dart';
import '../models/register_passenger_request_model.dart';
import '../models/resend_confirmation_request_model.dart';
import '../models/verify_otp_request_model.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  String defaultErrorMessage = 'Please try again later.';
  RegisterRepositoryImpl(this.remoteDataSource);

  // ---------------- DRIVER ----------------

  @override
  Future<Either<Failure, AuthResponse>> registerDriver(
    RegisterDriverRequest request,
  ) async {
    try {
      final model = RegisterDriverRequestModel(
        displayName: request.displayName,
        phoneNumber: request.phoneNumber,
        password: request.password,
        licenseNumber: request.licenseNumber,
      );

      final response = await remoteDataSource.registerDriver(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(defaultErrorMessage));
    }
  }

  // ---------------- PASSENGER ----------------

  @override
  Future<Either<Failure, AuthResponse>> registerPassenger(
    RegisterPassengerRequest request,
  ) async {
    try {
      final model = RegisterPassengerRequestModel(
        name: request.name,
        phoneNumber: request.phoneNumber,
        password: request.password,
      );

      final response = await remoteDataSource.registerPassenger(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(defaultErrorMessage));
    }
  }

  // ---------------- VERIFY OTP ----------------

  @override
  Future<Either<Failure, VerifyOtpResponseEntity>> verifyOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      final model = VerifyOtpRequestModel(
        phoneNumber: request.phoneNumber,
        otp: request.otp,
      );

      final response = await remoteDataSource.verifyOtp(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> confirmAccount(
    ConfirmAccountRequest request,
  ) async {
    try {
      final model = ConfirmAccountRequestModel(
        phoneNumber: request.phoneNumber,
        otp: request.otp,
      );

      final response = await remoteDataSource.confirmAccount(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> resendConfirmation(
    ResendConfirmationRequest request,
  ) async {
    try {
      final model = ResendConfirmationRequestModel(
        phoneNumber: request.phoneNumber,
      );

      final response = await remoteDataSource.resendConfirmation(model);

      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(defaultErrorMessage));
    }
  }
}
