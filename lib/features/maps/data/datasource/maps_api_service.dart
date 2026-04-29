import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_microbus/features/maps/data/models/location_model.dart';
import 'package:smart_microbus/features/maps/data/models/route_info_model.dart';
import 'package:smart_microbus/features/passener/data/models/base_response_model.dart';

import '../../../../core/networking/api_constants.dart';
import '../models/driver_location_model.dart';

import '../models/station_model.dart';
part 'maps_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MapsApiService {
  factory MapsApiService(Dio dio, {String baseUrl}) = _MapsApiService;
  @POST(ApiConstants.driverLocation)
  Future<BaseResponseModel> updateDriverLocation(
    @Body() LocationModel location,
  );
  @GET('${ApiConstants.driverLocation}/{driverId}')
  Future<DriverLocationModel> getDriverLocation(
    @Path('driverId') String driverId,
  );
  @GET(ApiConstants.nearestStations)
  Future<RouteInfoModel> getNearestStations(
    @Query('lat') double lat,
    @Query('lng') double lng,
    @Query('mode') String? mode,
  );
  @GET(ApiConstants.stations)
  Future<List<StationModel>> getStations();
  @GET('${ApiConstants.stations}/{id}')
  Future<StationModel> getStationById(@Path('id') String id);

  @GET(ApiConstants.routeBetweenStations)
  Future<RouteInfoModel> getRouteBetweenStation({
    @Query('fromStationId') required String fromStationId,
    @Query('toStationId') required String toStationId,
    @Query('mode') String? mode,
  });
  //api/v1/Stations/{id}/details-with-route
  @GET('${ApiConstants.stations}/{id}/details-with-route')
  Future<RouteInfoModel> getStationDetailsWithRoute(
    @Path('id') String id,
    @Query('lat') double lat,
    @Query('lng') double lng,
    @Query('mode') String? mode,
  );
}
