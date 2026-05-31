import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../passener/data/models/base_response_model.dart';
import '../../domain/repositories/staff_repository.dart';
import '../datasource/staff_remote_datasource.dart';

class StaffRepositoryImpl implements StaffRepository {
  final StaffRemoteDataSource remoteDataSource;

  StaffRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponseModel>> checkIn(String qrCode) async {
    try {
     final res = await remoteDataSource.checkIn(qrCode);
      return Right(res);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseModel>> checkOut(String qrCode) async {
    try {
      final res = await remoteDataSource.checkOut(qrCode);
      return Right(res);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
