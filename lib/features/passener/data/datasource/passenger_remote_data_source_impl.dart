import 'package:smart_microbus/features/passener/data/datasource/passenger_remote_data_source.dart';
import 'package:smart_microbus/features/passener/data/models/favourite_route_model.dart';
import 'package:smart_microbus/features/passener/data/models/on_the_way_microbus_model.dart';
import 'package:smart_microbus/features/passener/data/models/report_reason_model.dart';
import 'package:smart_microbus/features/passener/data/models/report_request_body_model.dart';
import 'package:smart_microbus/features/passener/data/models/route_model.dart';
import 'package:smart_microbus/features/passener/data/models/route_summary_model.dart';
import 'package:smart_microbus/features/passener/data/models/station_microbus_model.dart';

import '../models/destination_model.dart';
import 'passenger_api_service.dart';

class PassengerRemoteDataSourceImpl implements PassengerRemoteDataSource {
  final PassengerApiService apiService;

  PassengerRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<PassengerRouteModel>> getRoutes() {
    return apiService.getRoutes();
  }

  @override
  Future<List<DestinationModel>> getRouteDestinations(String from) {
    return apiService.getRouteDestinations(from);
  }

  @override
  Future<RouteSummaryModel> getRouteSummary(String routeId) {
    return apiService.getRouteSummary(routeId);
  }

  @override
  Future<List<StationMicrobusModel>> getStationMicrobuses(String routeId) {
    return apiService.getStationMicrobus(routeId);
  }

  @override
  Future<List<OnTheWayMicrobusModel>> getOnTheWayMicrobuses(String routeId) {
    return apiService.getOnTheWayMicrobuses(routeId);
  }

  @override
  Future<void> addRouteToFavorites(String routeId) {
    return apiService.addRouteToFavorites(routeId);
  }

  @override
  Future<List<FavouriteRouteModel>> getFavoriteRoutes() {
    return apiService.getFavoriteRoutes();
  }

  @override
  Future<void> removeRouteFromFavorites(String routeId) {
    return apiService.removeRouteFromFavorites(routeId);
  }

  @override
  Future<bool> isRouteFavorite(String routeId) {
    return apiService.isRouteFavorite(routeId);
  }

  @override
  Future<List<ReportReasonModel>> getReportReasons() {
    return apiService.getReportReasons();
  }

  @override
  Future<void> submitReport(ReportRequestBodyModel report) {
    return apiService.submitReport(report);
  }
}
