import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/entities/all_report_request_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/report.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/all_report_response_entity.dart';
import '../entities/base_response.dart';
import '../entities/destination_entity.dart';
import '../entities/favourite_route_entity.dart';
import '../entities/on_the_way_microbus_entity.dart';
import '../entities/report_entity.dart';
import '../entities/report_reason_entity.dart';
import '../entities/route_entity.dart';
import '../entities/route_summary_entity.dart';

abstract class PassengerRepo {
  Future<Either<Failure, List<PassengerRouteEntity>>> getRoutes();
  Future<Either<Failure, List<DestinationEntity>>> getRouteDestinations(
    String from,
  );
  Future<Either<Failure, RouteSummaryEntity>> getRouteSummary(String routeId);
  Future<Either<Failure, List<StationMicrobusEntity>>> getStationMicrobuses(
    String routeId,
  );
  Future<Either<Failure, List<OnTheWayMicrobusEntity>>> getOnTheWayMicrobuses(
    String routeId,
  );
  Future<Either<Failure, BaseResponse>> addRouteToFavorites(String routeId);
  Future<Either<Failure, BaseResponse>> removeRouteFromFavorites(
    String routeId,
  );
  Future<Either<Failure, List<FavouriteRouteEntity>>> getFavoriteRoutes();
  Future<Either<Failure, bool>> isRouteFavorite(String routeId);
  Future<Either<Failure, List<ReportReasonEntity>>> getReportReasons();
  Future<Either<Failure, BaseResponse>> submitReport(ReportEntity report);
  Future<Either<Failure, AllReportResponseEntity>> getAllReports(
    AllrportRequestEntity? requestEntity,
  );
  Future<Either<Failure, BaseResponse>> deleteReportById(String id);
  Future<Either<Failure, Report>> getReportById(String id);
  Future<Either<Failure, BaseResponse>> updateReport(
    String id,
    ReportEntity report,
  );
}
