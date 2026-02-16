import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/earning.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_event.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

class DriverHomeRepositoryImpl extends DriverHomeRepository {
  @override
  Future<Either<Failure, QueueItem>> getCurrentPosition() {
    // TODO: implement getCurrentPosition
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Earning>> getEstimatedDailyEarnings() {
    // TODO: implement getEstimatedDailyEarnings
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, QueueResponse>> getStationQueue({
    required String stationId,
    required String routeId,
  }) {
    // TODO: implement getStationQueue
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TripHistoryResponse>> getTripHistory() {
    // TODO: implement getTripHistory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, QueueEvent>> listenToQueueNotifications() {
    // TODO: implement listenToQueueNotifications
    throw UnimplementedError();
  }
}
