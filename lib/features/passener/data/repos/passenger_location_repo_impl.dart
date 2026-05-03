import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../maps/domain/entities/driver_location_entity.dart';
import '../../domain/entities/base_response.dart';
import '../../domain/repos/passenger_location_repo.dart';

import '../datasource/passenger_location_datasource.dart';

class PassengerLocationRepoImpl implements PassengerLocationRepo {
  final PassengerLocationDataSource dataSource;

  PassengerLocationRepoImpl(this.dataSource);

  @override
  Stream<DriverLocationEntity> get locationStream => dataSource.locationStream;

  @override
  Future<Either<Failure, void>> connect(String driverId) async {
    try {
      await dataSource.connect(driverId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      print("Disconnecting from driver location stream");
      await dataSource.disconnect();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> leaveDriver() {
    return dataSource.leaveDriver();
  }
}
