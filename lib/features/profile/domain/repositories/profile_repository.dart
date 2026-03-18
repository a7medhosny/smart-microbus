import 'package:dartz/dartz.dart';
import '../entities/profile.dart';
import '../../../../core/error/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();

  Future<Either<Failure, Unit>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<Failure, Unit>> logout();
}