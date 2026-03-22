import '../../domain/entities/profile.dart';

abstract class ProfileState {}

/// ==========================
/// General
/// ==========================
class ProfileInitial extends ProfileState {}

/// ==========================
/// Get Profile
/// ==========================
class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

/// ==========================
/// Reset Password
/// ==========================
class ResetPasswordLoading extends ProfileState {}

class ResetPasswordSuccess extends ProfileState {}

class ResetPasswordError extends ProfileState {
  final String message;

  ResetPasswordError(this.message);
}

/// ==========================
/// Logout
/// ==========================
class LogoutLoading extends ProfileState {}

class LogoutSuccess extends ProfileState {}

class LogoutError extends ProfileState {
  final String message;

  LogoutError(this.message);
}