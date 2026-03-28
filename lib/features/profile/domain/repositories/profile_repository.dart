import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/entities/base_response.dart';
import '../entities/profile.dart';
import '../../../../core/error/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();

  Future<Either<Failure, Unit>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });
  Future<Either<Failure, BaseResponse>> uploadProfilePhoto(File file);
  Future<Either<Failure, BaseResponse>> deleteProfilePhoto();
  Future<Either<Failure, BaseResponse>> deleteAccount();
  Future<Either<Failure, Unit>> logout();
}
