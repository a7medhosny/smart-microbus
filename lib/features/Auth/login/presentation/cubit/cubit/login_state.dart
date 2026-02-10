part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserEntity user;

  const LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class ForgetPasswordLoading extends LoginState {}

final class ForgetPasswordSuccess extends LoginState {
  final UserEntity user;

  const ForgetPasswordSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class ForgetPasswordFailure extends LoginState {
  final String message;

  const ForgetPasswordFailure({required this.message});
  @override
  List<Object> get props => [message];
}
