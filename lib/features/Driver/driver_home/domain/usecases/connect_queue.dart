import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

class ConnectQueue {
  final DriverHomeRepository repo;

  ConnectQueue(this.repo);

  Future<Either<Failure, Unit>> call(String queueId) {
    return repo.connectToQueue(queueId);
  }
}
