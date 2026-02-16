import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/core/error/error_handler.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/earning.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_event.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

import '../datasources/driver_home_data_source.dart';

class DriverHomeRepositoryImpl extends DriverHomeRepository {
  final DriverHomeDataSource dataSource;

  DriverHomeRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, QueueItem>> getCurrentPosition() async {
    try {
      final result = await dataSource.getCurrentPosition();
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Earning>> getEstimatedDailyEarnings() async {
    try {
      final result = await dataSource.getEstimatedDailyEarnings();
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QueueResponse>> getStationQueue({
    required String stationId,
    required String routeId,
  }) async {
    try {
      final result = await dataSource.getStationQueue(
        stationId: stationId,
        routeId: routeId,
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TripHistoryResponse>> getTripHistory() async {
    try {
      final result = await dataSource.getTripHistory();
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QueueEvent>> listenToQueueNotifications() {
    // TODO: implement listenToQueueNotifications
    throw UnimplementedError();
  }
}
