import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../passener/domain/entities/base_response.dart';
import '../repositories/profile_repository.dart';

class DeleteProfilePhotoUseCase {
  final ProfileRepository repo;

  DeleteProfilePhotoUseCase(this.repo);

  Future<Either<Failure, BaseResponse>> call() async {
    return repo.deleteProfilePhoto();
  }
}
