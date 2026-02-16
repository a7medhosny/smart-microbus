import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/earning.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_event.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';

import '../../../../../core/error/failure.dart';

abstract class DriverHomeRepository {
  Future<Either<Failure, QueueItem>>getCurrentPosition();
  Future<Either<Failure, QueueResponse>>getStationQueue({
    required String stationId,
    required String routeId
  });
  Future<Either<Failure, QueueEvent>>listenToQueueNotifications();
  Future<Either<Failure, TripHistoryResponse>>getTripHistory();
  Future<Either<Failure, Earning>>getEstimatedDailyEarnings();

}