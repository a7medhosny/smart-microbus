import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source.dart';
import 'package:smart_microbus/features/Auth/login/data/models/reset_password_model.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_data_source.dart';
import '../mappers/profile_mapper.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;
  final LoginRemoteDataSource loginRemoteDataSource;

  ProfileRepositoryImpl(this.remote, this.loginRemoteDataSource);

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final result = await remote.getProfile();
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
       await loginRemoteDataSource.resetPassword(
        ResetPasswordModel(
          userId: TokenManager.userId ?? '',
          token: TokenManager.token ?? '',
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );
            return Right(unit);

    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
       await remote.logout();
      return Right(unit);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}