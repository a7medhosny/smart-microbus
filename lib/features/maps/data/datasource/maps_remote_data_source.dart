import 'package:smart_microbus/features/maps/data/models/driver_location_model.dart';
import 'package:smart_microbus/features/maps/data/models/location_model.dart';
import 'package:smart_microbus/features/maps/data/models/nearest_station_result_model.dart';
import 'package:smart_microbus/features/maps/data/models/route_info_model.dart';
import 'package:smart_microbus/features/maps/data/models/station_model.dart';
import 'package:smart_microbus/features/passener/data/models/base_response_model.dart';

import '../../domain/enums/travel_mode.dart';

abstract class MapsRemoteDataSource {
  Future<BaseResponseModel> updateDriverLocation(LocationModel location);
  Future<DriverLocationModel> getDriverLocation(String driverId);
  Future< NearestStationResultModel> getNearestStation({
    required LocationModel location,
    TravelMode? mode,
  });
  Future<List<StationModel>> getStations();
  Future<StationModel> getStationById(String id);
  Future<RouteInfoModel> getRouteBetweenStation({
    required String fromStationId,
    required String toStationId,
    TravelMode? mode,
  });
  Future<RouteInfoModel> getStationDetailsWithRoute({
    required String id,
    required LocationModel location,
    TravelMode? mode,
  });
}
