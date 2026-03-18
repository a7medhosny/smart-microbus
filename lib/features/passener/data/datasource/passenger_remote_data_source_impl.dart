import 'package:smart_microbus/features/passener/data/datasource/passenger_remote_data_source.dart';
import 'package:smart_microbus/features/passener/data/models/on_the_way_microbus_model.dart';
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
}
