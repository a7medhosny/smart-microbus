import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/profile/domain/repositories/profile_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../passener/domain/entities/base_response.dart';

class UploadProfilePhotoUseCase {
  final ProfileRepository repo;

  UploadProfilePhotoUseCase(this.repo);
  Future<Either<Failure, BaseResponse>> call(File photo) async {
    return repo.uploadProfilePhoto(photo);
  }
}
