import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/profile/domain/usecases/delete_profile_photo_use_case.dart';
import 'package:smart_microbus/features/profile/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:smart_microbus/features/profile/presentation/cubit/profile_state.dart';

import '../../domain/entities/profile.dart';
import '../../domain/usecases/delete_account_use_case.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/change_password_usecase.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  final DeleteProfilePhotoUseCase deleteProfilePhotoUseCase;
  Profile? currentUserProfile;
  ProfileCubit(
    this.getProfileUseCase,
    this.changePasswordUseCase,
    this.logoutUseCase, {
    required this.deleteAccountUseCase,
    required this.uploadProfilePhotoUseCase,
    required this.deleteProfilePhotoUseCase,
  }) : super(ProfileInitial());

  /// ==========================
  /// Get Profile
  /// ==========================
  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final result = await getProfileUseCase();

    result.fold((failure) => emit(ProfileError(failure.message)), (profile) {
      currentUserProfile = profile;
      emit(ProfileLoaded(profile));
    });
  }

  /// ==========================
  /// Reset Password
  /// ==========================
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());

    final result = await changePasswordUseCase(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) => emit(ResetPasswordError(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }

  /// ==========================
  /// Logout
  /// ==========================
  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await logoutUseCase();

    result.fold((failure) => emit(LogoutError(failure.message)), (_) {
      emit(LogoutSuccess());
    });
  }

  Future<void> deleteAccount() async {
    emit(ProfileDeleteAccountLoading());
    final result = await deleteAccountUseCase();
    result.fold(
      (failure) => emit(ProfileDeleteAccountError(message: failure.message)),
      (mess) => emit(ProfileDeleteAccountSuccess(message: mess.message)),
    );
  }

  Future<void> uploadProfilePhoto(File photo) async {
    emit(ProfilePhotoUploading());

    final result = await uploadProfilePhotoUseCase(photo);

    await result.fold(
      (failure) async {
        emit(ProfilePhotoUploadError(message: failure.message));
      },
      (mess) async {
        final profileResult = await getProfileUseCase();

        profileResult.fold(
          (failure) {
            emit(ProfilePhotoUploadError(message: failure.message));
          },
          (profile) {
            currentUserProfile = profile;
            emit(ProfileLoaded(profile));
          },
        );
      },
    );
  }

  Future<void> deleteProfilePhoto() async {
    emit(ProfilePhotoDeletLoading());

    final result = await deleteProfilePhotoUseCase();

    result.fold(
      (failure) => emit(ProfilePhotoDeleteError(message: failure.message)),
      (mess) {
        if (currentUserProfile != null) {
          currentUserProfile = currentUserProfile!.copyWith(photoUrl: null);

          emit(ProfileLoaded(currentUserProfile!));
        }
      },
    );
  }
}
