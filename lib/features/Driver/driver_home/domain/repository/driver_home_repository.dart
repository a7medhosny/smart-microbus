import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/earning.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_event.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';

import '../../../../../core/error/failure.dart';

import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class DriverHomeRepository {
  Future<Either<Failure, QueueItem>> getCurrentPosition();

  Future<Either<Failure, List<QueueItem>>> getStationQueue({
    required String driverId,
  });

  Stream<QueueEvent> listenToQueueNotifications();

  Future<Either<Failure, TripHistoryResponse>> getTripHistory();

  Future<Either<Failure, Earning>> getEstimatedDailyEarnings();

  Future<Either<Failure, Unit>> connectToQueue(String queueId);

  Future<Either<Failure, Unit>> startTrip({
    required String driverId,
  });

  Future<Either<Failure, Unit>> endTrip({
    required String driverId,
  });
}
