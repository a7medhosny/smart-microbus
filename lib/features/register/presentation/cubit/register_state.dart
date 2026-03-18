part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

// ================= INITIAL =================

final class RegisterInitial extends RegisterState {}

// ================= DRIVER =================

final class RegisterDriverLoading extends RegisterState {}

final class RegisterDriverSuccess extends RegisterState {
  final AuthResponse response;

  const RegisterDriverSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class RegisterDriverError extends RegisterState {
  final String message;

  const RegisterDriverError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= PASSENGER =================

final class RegisterPassengerLoading extends RegisterState {}

final class RegisterPassengerSuccess extends RegisterState {
  final AuthResponse response;

  const RegisterPassengerSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class RegisterPassengerError extends RegisterState {
  final String message;

  const RegisterPassengerError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= VERIFY OTP =================

final class VerifyOtpLoading extends RegisterState {}

final class VerifyOtpSuccess extends RegisterState {
  final VerifyOtpResponseEntity response;
  const VerifyOtpSuccess(this.response);
}

final class VerifyOtpError extends RegisterState {
  final String message;

  const VerifyOtpError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= CONFIRM ACCOUNT =================

final class ConfirmAccountLoading extends RegisterState {}

final class ConfirmAccountSuccess extends RegisterState {
  final AuthResponse response;

  const ConfirmAccountSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class ConfirmAccountError extends RegisterState {
  final String message;

  const ConfirmAccountError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= RESEND CONFIRMATION =================

final class ResendConfirmationLoading extends RegisterState {}

final class ResendConfirmationSuccess extends RegisterState {
  final AuthResponse response;

  const ResendConfirmationSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class ResendConfirmationError extends RegisterState {
  final String message;

  const ResendConfirmationError(this.message);

  @override
  List<Object?> get props => [message];
}
