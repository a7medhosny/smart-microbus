import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/passener/domain/entities/destination_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/on_the_way_microbus_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/route_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/route_summary_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';

import '../../../../core/error/error_handler.dart';
import '../datasource/passenger_remote_data_source.dart';

class PassengerRepoImpl implements PassengerRepo {
  final PassengerRemoteDataSource remoteDataSource;
  static const String errorMessage =
      'An unexpected error occurred. Please try again later.';
  PassengerRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<PassengerRouteEntity>>> getRoutes() async {
    try {
      final routes = await remoteDataSource.getRoutes();
      return Right(routes);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> getRouteDestinations(
    String from,
  ) async {
    try {
      final destinations = await remoteDataSource.getRouteDestinations(from);
      return Right(destinations);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, RouteSummaryEntity>> getRouteSummary(
    String routeId,
  ) async {
    try {
      final routeSummary = await remoteDataSource.getRouteSummary(routeId);
      return Right(routeSummary);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<StationMicrobusEntity>>> getStationMicrobus(
    String routeId,
  ) async {
    try {
      final stationMicrobuses = await remoteDataSource.getStationMicrobuses(
        routeId,
      );
      return Right(stationMicrobuses);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<OnTheWayMicrobusEntity>>> getOnTheWayMicrobuses(
    String routeId,
  ) async {
    try {
      final onTheWayMicrobuses = await remoteDataSource.getOnTheWayMicrobuses(
        routeId,
      );
      return Right(onTheWayMicrobuses);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }
  
  @override
  Future<Either<Failure, List<StationMicrobusEntity>>> getStationMicrobuses(String routeId) async {
    try {
      final stationMicrobuses = await remoteDataSource.getStationMicrobuses(
        routeId,
      );
      return Right(stationMicrobuses);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }
}
