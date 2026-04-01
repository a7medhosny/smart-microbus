import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

class DisconnectQueue {
  final DriverHomeRepository repo;

  DisconnectQueue(this.repo);

  Future<Either<Failure, Unit>> call() {
    return repo.disconnectQueue();
  }
}