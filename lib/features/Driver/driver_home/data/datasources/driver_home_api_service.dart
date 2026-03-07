import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/earning_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/queue_item_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/queue_response_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/trip_history_response_model.dart';

import '../../../../../core/networking/api_constants.dart';

part 'driver_home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DriverHomeApiService {
  factory DriverHomeApiService(Dio dio, {String baseUrl}) =
      _DriverHomeApiService;
  @GET(ApiConstants.currentPosition)
  Future<QueueItemModel> getCurrentPosition();
  @GET(ApiConstants.stationQueue)
  Future<List<QueueItemModel>> getStationQueue({
    // @Path('stationId') required String stationId,
    // @Path('routeId') required String routeId,
    @Query('driverId') required String driverId,
  });
  @GET(ApiConstants.tripHistory)
  Future<TripHistoryResponseModel> getTripHistory();
  @GET(ApiConstants.estmstimatedEarnings)
  Future<EarningModel> getEstimatedDailyEarnings();

  @POST(ApiConstants.startTrip)
  Future<void> startTrip({
    @Query('driverId') required String driverId,
  });

  @POST(ApiConstants.endTrip)
  Future<void> endTrip({
    @Query('driverId') required String driverId,
  });

}
