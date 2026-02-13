import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/user_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/repos/login_repo.dart';

class LoginUseCase {
  final LoginRepo repo;

  LoginUseCase(this.repo);
  Future<Either<Failure, UserEntity>> call(LoginEntity loginEntity) {
    return repo.login(loginEntity);
  }
}
