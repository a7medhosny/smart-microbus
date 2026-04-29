import 'package:smart_microbus/features/maps/data/datasource/maps_remote_data_source.dart';
import 'package:smart_microbus/features/maps/data/models/driver_location_model.dart';
import 'package:smart_microbus/features/maps/data/models/location_model.dart';
import 'package:smart_microbus/features/maps/data/models/route_info_model.dart';
import 'package:smart_microbus/features/maps/data/models/station_model.dart';
import 'package:smart_microbus/features/maps/domain/enums/travel_mode.dart';
import 'package:smart_microbus/features/passener/data/models/base_response_model.dart';

import 'maps_api_service.dart';

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final MapsApiService api;

  MapsRemoteDataSourceImpl(this.api);

  @override
  Future<DriverLocationModel> getDriverLocation(String driverId) {
    return api.getDriverLocation(driverId);
  }

  @override
  Future<RouteInfoModel> getNearestStation({
    required LocationModel location,
    TravelMode? mode,
  }) {
    return api.getNearestStations(
      location.latitude,
      location.longitude,
      mode?.value,
    );
  }

  @override
  Future<RouteInfoModel> getRouteBetweenStation({
    required String fromStationId,
    required String toStationId,
    TravelMode? mode,
  }) {
    return api.getRouteBetweenStation(
      fromStationId: fromStationId,
      toStationId: toStationId,
      mode: mode?.value,
    );
  }

  @override
  Future<StationModel> getStationById(String id) {
    return api.getStationById(id);
  }

  @override
  Future<List<StationModel>> getStations() {
    return api.getStations();
  }

  @override
  Future<BaseResponseModel> updateDriverLocation(LocationModel location) {
    return api.updateDriverLocation(location);
  }

  @override
  Future<RouteInfoModel> getStationDetailsWithRoute({
    required String id,
    required LocationModel location,
    TravelMode? mode,
  }) {
    return api.getStationDetailsWithRoute(
      id,
      location.latitude,
      location.longitude,
      mode?.value,
    );
  }
}
