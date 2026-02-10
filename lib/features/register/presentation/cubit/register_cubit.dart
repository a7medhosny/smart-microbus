import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/entities/confirm_account_request.dart';
import '../../domain/entities/register_driver_request.dart';
import '../../domain/entities/register_passenger_request.dart';
import '../../domain/entities/resend_confirmation_request.dart';
import '../../domain/entities/verify_otp_request.dart';

import '../../domain/usecases/confirm_account_use_case.dart';
import '../../domain/usecases/register_driver_use_case.dart';
import '../../domain/usecases/register_passenger_use_case.dart';
import '../../domain/usecases/resend_confirmation_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterDriverUseCase registerDriverUseCase;
  final RegisterPassengerUseCase registerPassengerUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ConfirmAccountUseCase confirmAccountUseCase;
  final ResendConfirmationUseCase resendConfirmationUseCase;

  RegisterCubit(
    this.registerDriverUseCase,
    this.registerPassengerUseCase,
    this.verifyOtpUseCase,
    this.confirmAccountUseCase,
    this.resendConfirmationUseCase,
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

  // ================= CONFIRM ACCOUNT =================

Future<void> confirmAccount({
  required String phoneNumber,
  required String otp,
}) async {
  emit(ConfirmAccountLoading());

  final request = ConfirmAccountRequest(
    phoneNumber: phoneNumber,
    otp: otp,
  );

  final result =
      await confirmAccountUseCase(request);

  result.fold(
    (failure) => emit(
      ConfirmAccountError(
        failure.message ??
            'Confirmation failed',
      ),
    ),
    (response) => emit(
      ConfirmAccountSuccess(response),
    ),
  );
}


// ================= RESEND CONFIRMATION =================

Future<void> resendConfirmation({
  required String phoneNumber,
}) async {
  emit(ResendConfirmationLoading());

  final request =
      ResendConfirmationRequest(
    phoneNumber: phoneNumber,
  );

  final result =
      await resendConfirmationUseCase(
    request,
  );

  result.fold(
    (failure) => emit(
      ResendConfirmationError(
        failure.message ??
            'Failed to resend code',
      ),
    ),
    (response) => emit(
      ResendConfirmationSuccess(
        response,
      ),
    ),
  );
}


}
