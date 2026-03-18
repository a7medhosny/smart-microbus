import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repo;

  GetProfileUseCase(this.repo);

  Future<Either<Failure, Profile>> call() {
    return repo.getProfile();
  }
}