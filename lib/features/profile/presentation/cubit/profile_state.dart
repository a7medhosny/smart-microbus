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

/// ==========================
/// Delete Account
/// ==========================

final class ProfileDeleteAccountLoading extends ProfileState {}

final class ProfileDeleteAccountSuccess extends ProfileState {
  final String message;

  ProfileDeleteAccountSuccess({required this.message});
}

final class ProfileDeleteAccountError extends ProfileState {
  final String message;

  ProfileDeleteAccountError({required this.message});
}
// ==========================
//upload photo

final class ProfilePhotoUploading extends ProfileState {}

final class ProfilePhotoUploadSuccess extends ProfileState {
  final String message;

  ProfilePhotoUploadSuccess({required this.message});
}

final class ProfilePhotoUploadError extends ProfileState {
  final String message;

  ProfilePhotoUploadError({required this.message});
}

// ==========================
//delete photo
final class ProfilePhotoDeletLoading extends ProfileState {}

final class ProfilePhotoDeleteSuccess extends ProfileState {
  final String message;

  ProfilePhotoDeleteSuccess({required this.message});
}

final class ProfilePhotoDeleteError extends ProfileState {
  final String message;

  ProfilePhotoDeleteError({required this.message});
}
