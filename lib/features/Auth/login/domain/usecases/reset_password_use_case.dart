import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/reset_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/repos/login_repo.dart';

class ResetPasswordUseCase {
  final LoginRepo repo;

  ResetPasswordUseCase(this.repo);
  Future<Either<Failure, void>> call(ResetPasswordEntity resetPasswordEntity) {
    return repo.resetPassword(resetPasswordEntity);
  }
}
