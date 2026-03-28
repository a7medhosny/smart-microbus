import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/entities/base_response.dart';

import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository profileRepo;

  DeleteAccountUseCase(this.profileRepo);

  Future<Either<Failure, BaseResponse>> call() {
    return profileRepo.deleteAccount();
  }
}
