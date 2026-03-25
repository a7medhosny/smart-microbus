import '../models/base_response_model.dart';
import '../models/destination_model.dart';
import '../models/favourite_route_model.dart';
import '../models/on_the_way_microbus_model.dart';
import '../models/report_reason_model.dart';
import '../models/report_request_body_model.dart';
import '../models/route_model.dart';
import '../models/route_summary_model.dart';
import '../models/station_microbus_model.dart';

abstract class PassengerRemoteDataSource {
  Future<List<PassengerRouteModel>> getRoutes();
  Future<List<DestinationModel>> getRouteDestinations(String from);
  Future<RouteSummaryModel> getRouteSummary(String routeId);
  Future<List<StationMicrobusModel>> getStationMicrobuses(String routeId);
  Future<List<OnTheWayMicrobusModel>> getOnTheWayMicrobuses(String routeId);
  Future<BaseResponseModel> addRouteToFavorites(String routeId);
  Future<BaseResponseModel> removeRouteFromFavorites(String routeId);
  Future<List<FavouriteRouteModel>> getFavoriteRoutes();
  Future<bool> isRouteFavorite(String routeId);
  Future<List<ReportReasonModel>> getReportReasons();
  Future<BaseResponseModel> submitReport(ReportRequestBodyModel report);
}
