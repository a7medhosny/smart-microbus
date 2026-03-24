import '../models/destination_model.dart';
import '../models/favourite_route_model.dart';
import '../models/on_the_way_microbus_model.dart';
import '../models/route_model.dart';
import '../models/route_summary_model.dart';
import '../models/station_microbus_model.dart';

abstract class PassengerRemoteDataSource {
  Future<List<PassengerRouteModel>> getRoutes();
  Future<List<DestinationModel>> getRouteDestinations(String from);
  Future<RouteSummaryModel> getRouteSummary(String routeId);
  Future<List<StationMicrobusModel>> getStationMicrobuses(String routeId);
  Future<List<OnTheWayMicrobusModel>> getOnTheWayMicrobuses(String routeId);
  Future<void> addRouteToFavorites(String routeId);
  Future<void> removeRouteFromFavorites(String routeId);
  Future<List<FavouriteRouteModel>> getFavoriteRoutes();
  Future<bool> isRouteFavorite(String routeId);
}
