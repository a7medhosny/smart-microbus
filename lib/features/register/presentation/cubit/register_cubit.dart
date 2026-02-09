import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/entities/register_driver_request.dart';
import '../../domain/entities/register_passenger_request.dart';
import '../../domain/entities/verify_otp_request.dart';

import '../../domain/usecases/register_driver_use_case.dart';
import '../../domain/usecases/register_passenger_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterDriverUseCase
      registerDriverUseCase;
  final RegisterPassengerUseCase
      registerPassengerUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  RegisterCubit(
    this.registerDriverUseCase,
    this.registerPassengerUseCase,
    this.verifyOtpUseCase,
  ) : super(RegisterInitial());

  // ================= DRIVER =================

  Future<void> registerDriver({
    required String displayName,
    required String phoneNumber,
    required String password,
    required String licenseNumber,
  }) async {
    emit(RegisterDriverLoading());

    final request = RegisterDriverRequest(
      displayName: displayName,
      phoneNumber: phoneNumber,
      password: password,
      licenseNumber: licenseNumber,
    );

    final result =
        await registerDriverUseCase(request);

    result.fold(
      (failure) => emit(
        RegisterDriverError(
          failure.message ??
              'Something went wrong',
        ),
      ),
      (response) => emit(
        RegisterDriverSuccess(response),
      ),
    );
  }

  // ================= PASSENGER =================

  Future<void> registerPassenger({
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    emit(RegisterPassengerLoading());

    final request =
        RegisterPassengerRequest(
      name: name,
      phoneNumber: phoneNumber,
      password: password,
    );

    final result =
        await registerPassengerUseCase(
      request,
    );

    result.fold(
      (failure) => emit(
        RegisterPassengerError(
          failure.message ??
              'Something went wrong',
        ),
      ),
      (response) => emit(
        RegisterPassengerSuccess(
          response,
        ),
      ),
    );
  }

  // ================= VERIFY OTP =================

  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(VerifyOtpLoading());

    final request = VerifyOtpRequest(
      phoneNumber: phoneNumber,
      otp: otp,
    );

    final result =
        await verifyOtpUseCase(request);

    result.fold(
      (failure) => emit(
        VerifyOtpError(
          failure.message ??
              'Invalid OTP',
        ),
      ),
      (_) => emit(VerifyOtpSuccess()),
    );
  }
}
