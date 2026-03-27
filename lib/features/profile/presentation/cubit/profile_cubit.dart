import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/profile/presentation/cubit/profile_state.dart';

import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/change_password_usecase.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit(
    this.getProfileUseCase,
    this.changePasswordUseCase,
    this.logoutUseCase,
  ) : super(ProfileInitial());

  /// ==========================
  /// Get Profile
  /// ==========================
  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
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
}
