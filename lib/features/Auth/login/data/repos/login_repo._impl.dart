import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/core/error/error_handler.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source.dart';
import 'package:smart_microbus/features/Auth/login/data/models/forget_password_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_request_model.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/user_entity.dart';
import 'package:smart_microbus/features/Auth/login/domain/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl(this.loginRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(LoginEntity loginEntity) async {
    try {
      final loginRequestModel = LoginRequestModel.fromEntity(loginEntity);
      final result = await loginRemoteDataSource.login(loginRequestModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> forgetPassword(
    ForgetPasswordEntity forgetPasswordEntity,
  ) async {
    try {
      final forgetPasswordRequestModel = ForgetPasswordRequestModel.fromEntity(
        forgetPasswordEntity,
      );
      final result = await loginRemoteDataSource.forgetPassword(
        forgetPasswordRequestModel,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
