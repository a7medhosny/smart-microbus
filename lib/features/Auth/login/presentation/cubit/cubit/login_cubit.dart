import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/user_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/forget_password_use_case.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase, required this.forgetPasswordUseCase})
    : super(LoginInitial());
  final LoginUseCase loginUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
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
      (user) => emit(ForgetPasswordSuccess(user: user)),
    );
  }
}
