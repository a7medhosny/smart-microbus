import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:smart_microbus/core/error/failure.dart';

import 'package:smart_microbus/features/maps/domain/entities/driver_location_entity.dart';

import 'package:smart_microbus/features/maps/domain/entities/location_entity.dart';

import 'package:smart_microbus/features/maps/domain/entities/station_entity.dart';

import 'package:smart_microbus/features/maps/domain/enums/travel_mode.dart';

import 'package:smart_microbus/features/passener/domain/entities/base_response.dart';

import '../../../../core/error/error_handler.dart';
import '../../domain/entities/route_info_entity.dart';
import '../../domain/repos/maps_repo.dart';
import '../datasource/maps_remote_data_source.dart';
import '../models/location_model.dart';

class MapsRepoImpl implements MapsRepo {
  final MapsRemoteDataSource remoteDataSource;

  MapsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, DriverLocationEntity>> getDriverLocation(
    String driverId,
  ) async {
    try {
      final result = await remoteDataSource.getDriverLocation(driverId);
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RouteInfoEntity>> getNearestStation({
    required LocationEntity location,
    TravelMode? mode,
  }) async {
    try {
      final result = await remoteDataSource.getNearestStation(
        location: LocationModel.fromEntity(location),
        mode: mode,
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RouteInfoEntity>> getRouteBetweenStation({
    required String fromStationId,
    required String toStationId,
    TravelMode? mode,
  }) async {
    try {
      final result = await remoteDataSource.getRouteBetweenStation(
        fromStationId: fromStationId,
        toStationId: toStationId,
        mode: mode,
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StationEntity>> getStationById(String id) async {
    try {
      final result = await remoteDataSource.getStationById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StationEntity>>> getStations() async {
    try {
      final result = await remoteDataSource.getStations();
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> updateDriverLocation(
    LocationEntity location,
  ) async {
    try {
      final result = await remoteDataSource.updateDriverLocation(
        LocationModel.fromEntity(location),
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RouteInfoEntity>> getStationDetailsWithRoute({
    required String id,
    required LocationEntity location,
    TravelMode? mode,
  }) async {
    try {
      final result = await remoteDataSource.getStationDetailsWithRoute(
        id: id,
        location: LocationModel.fromEntity(location),
        mode: mode,
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
