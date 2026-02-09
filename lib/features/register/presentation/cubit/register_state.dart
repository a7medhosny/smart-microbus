part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

// ================= INITIAL =================

final class RegisterInitial extends RegisterState {}

// ================= DRIVER =================

final class RegisterDriverLoading
    extends RegisterState {}

final class RegisterDriverSuccess
    extends RegisterState {
  final AuthResponse response;

  const RegisterDriverSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class RegisterDriverError
    extends RegisterState {
  final String message;

  const RegisterDriverError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= PASSENGER =================

final class RegisterPassengerLoading
    extends RegisterState {}

final class RegisterPassengerSuccess
    extends RegisterState {
  final AuthResponse response;

  const RegisterPassengerSuccess(
    this.response,
  );

  @override
  List<Object?> get props => [response];
}

final class RegisterPassengerError
    extends RegisterState {
  final String message;

  const RegisterPassengerError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

// ================= VERIFY OTP =================

final class VerifyOtpLoading
    extends RegisterState {}

final class VerifyOtpSuccess
    extends RegisterState {}

final class VerifyOtpError
    extends RegisterState {
  final String message;

  const VerifyOtpError(this.message);

  @override
  List<Object?> get props => [message];
}
