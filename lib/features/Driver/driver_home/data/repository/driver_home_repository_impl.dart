import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/core/error/error_handler.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/queue_item_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/earning.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_event.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

import '../../domain/entities/dashboard_event.dart';
import '../../domain/entities/driver_current_status.dart';
import '../datasources/driver_home_data_source.dart';
import '../datasources/queue_signalr_datasource.dart';

class DriverHomeRepositoryImpl extends DriverHomeRepository {
  final DriverHomeDataSource dataSource;
  final QueueSignalRDataSource signalRDataSource;

  DriverHomeRepositoryImpl(this.dataSource, this.signalRDataSource);

  @override
  Future<Either<Failure, DriverCurrentStatus>> getCurrentPosition() async {
    try {
      final result = await dataSource.getCurrentPosition();
      return Right(result.toEntity());
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
  Future<Either<Failure, List<QueueItem>>> getStationQueue({
    required String driverId,
  }) async {
    try {
      final result = await dataSource.getStationQueue(driverId: driverId);

      return Right(result.map((item) => item.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TripHistoryResponse>> getTripHistory({
    DateTime? fromDate,
    DateTime? toDate,
    int? pageSize,
    int? pageNumber,
  }) async {
    try {
      final result = await dataSource.getTripHistory(
        fromDate: fromDate,
        toDate: toDate,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



  // ================= SIGNALR =================

  @override
  Stream<QueueEvent> listenToQueueNotifications() {
    return signalRDataSource.queueEvents;
  }

  @override
  Stream<DashboardEvent> listenToDashboardNotifications() {
    return signalRDataSource.dashboardEvents;
  }

  @override
  Future<Either<Failure, Unit>> connectToQueue(String queueId) async {
    try {
      await signalRDataSource.connectQueue(queueId); 
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> connectToDashboard() async {
    try {
      await signalRDataSource.connectDashboard();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnectQueue() async {
    try {
      await signalRDataSource.disconnectQueue();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnectDashboard() async {
    try {
      await signalRDataSource.disconnectDashboard();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Unit>> startTrip({required String driverId}) async {
    try {
      await dataSource.startTrip(driverId: driverId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> endTrip({required String driverId}) async {
    try {
      await dataSource.endTrip(driverId: driverId);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
