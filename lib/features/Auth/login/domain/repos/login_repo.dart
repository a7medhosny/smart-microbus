import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/user_entity.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserEntity>> login(LoginEntity loginEntity);
  Future<Either<Failure, UserEntity>> forgetPassword(
    ForgetPasswordEntity forgetPasswordEntity,
  );
}
