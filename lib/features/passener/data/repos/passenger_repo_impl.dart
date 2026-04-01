import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/passener/data/models/all_report_response_model.dart';
import 'package:smart_microbus/features/passener/domain/entities/all_report_request_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/all_report_response_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/base_response.dart';
import 'package:smart_microbus/features/passener/domain/entities/destination_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/favourite_route_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/on_the_way_microbus_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/report.dart';
import 'package:smart_microbus/features/passener/domain/entities/report_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/report_reason_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/route_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/route_summary_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';

import '../../../../core/error/error_handler.dart';
import '../datasource/passenger_remote_data_source.dart';
import '../models/all_report_request_model.dart';
import '../models/base_response_model.dart';
import '../models/report_request_body_model.dart';

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
  Future<Either<Failure, List<StationMicrobusEntity>>> getStationMicrobuses(
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
  Future<Either<Failure, BaseResponseModel>> addRouteToFavorites(
    String routeId,
  ) async {
    try {
      final result = await remoteDataSource.addRouteToFavorites(routeId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<FavouriteRouteEntity>>>
  getFavoriteRoutes() async {
    try {
      final favoriteRoutes = await remoteDataSource.getFavoriteRoutes();

      return Right(favoriteRoutes);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, BaseResponseModel>> removeRouteFromFavorites(
    String routeId,
  ) async {
    try {
      final result = await remoteDataSource.removeRouteFromFavorites(routeId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> isRouteFavorite(String routeId) async {
    try {
      final isFavorite = await remoteDataSource.isRouteFavorite(routeId);
      return Right(isFavorite);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ReportReasonEntity>>> getReportReasons() async {
    try {
      final reportReasons = await remoteDataSource.getReportReasons();
      return Right(reportReasons);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, BaseResponseModel>> submitReport(
    ReportEntity report,
  ) async {
    try {
      final result = await remoteDataSource.submitReport(
        ReportRequestBodyModel.fromEntity(report),
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, AllReportResponseEntity>> getAllReports(
    AllrportRequestEntity? requestEntity,
  ) async {
    try {
      final response = await remoteDataSource.getAllReports(
        AllReportRequestModel(
          plateNumber: requestEntity?.plateNumber,
          fromDate: requestEntity?.fromDate,
          toDate: requestEntity?.toDate,
          pageNumber: requestEntity?.pageNumber,
          pageSize: requestEntity?.pageSize,
        ),
      );

      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> deleteReportById(String id) async {
    try {
      final result = await remoteDataSource.deleteReportById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, Report>> getReportById(String id) async {
    try {
      final report = await remoteDataSource.getReportById(id);
      return Right(report);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> updateReport(
    String id,
    ReportEntity report,
  ) async {
    try {
      final result = await remoteDataSource.updateReport(
        id,
        ReportRequestBodyModel.fromEntity(report),
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

    @override
  Future<Either<Failure, StationMicrobusEntity>> getDriverByPlateNumber(
    String plateNumber,
  ) async {
    try {
      final driver = await remoteDataSource.getDriverByPlateNumber(
        plateNumber,
      );
      return Right(driver);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }
}
