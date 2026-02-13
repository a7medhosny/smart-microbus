import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/repos/login_repo.dart';

class ForgetPasswordUseCase {
  final LoginRepo repo;

  ForgetPasswordUseCase(this.repo);
  Future<Either<Failure, void>> call(
    ForgetPasswordEntity forgetPasswordEntity,
  ) {
    return repo.forgetPassword(forgetPasswordEntity);
  }
}
