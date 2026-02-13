import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/reset_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/user_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/forget_password_use_case.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/login_use_case.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/reset_password_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginUseCase,
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(LoginInitial());
  final LoginUseCase loginUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  Future<void> login({required LoginEntity entity}) async {
    emit(LoginLoading());
    final result = await loginUseCase(entity);
    result.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }

  Future<void> forgetPassword({required ForgetPasswordEntity entity}) async {
    emit(ForgetPasswordLoading());
    final result = await forgetPasswordUseCase(entity);
    result.fold(
      (failure) => emit(ForgetPasswordFailure(message: failure.message)),
      (_) => emit(ForgetPasswordSuccess()),
    );
  }

  Future<void> resetPassword({required ResetPasswordEntity entity}) async {
    emit(ResetPasswordLoading());
    final result = await resetPasswordUseCase(entity);
    result.fold(
      (failure) => emit(ResetPasswordFailure(message: failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
