import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository repo;

  ChangePasswordUseCase(this.repo);

  Future<Either<Failure, Unit>> call({
    required String newPassword,
    required String confirmPassword,
  }) {
    return repo.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
