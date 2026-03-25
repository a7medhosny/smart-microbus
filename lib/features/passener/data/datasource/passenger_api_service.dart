import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_microbus/features/passener/data/models/destination_model.dart';
import 'package:smart_microbus/features/passener/data/models/route_model.dart';

import '../../../../core/networking/api_constants.dart';
import '../../domain/entities/base_response.dart';
import '../models/base_response_model.dart';
import '../models/favourite_route_model.dart';
import '../models/on_the_way_microbus_model.dart';
import '../models/report_reason_model.dart';
import '../models/report_request_body_model.dart';
import '../models/route_summary_model.dart';
import '../models/station_microbus_model.dart';

part 'passenger_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PassengerApiService {
  factory PassengerApiService(Dio dio, {String baseUrl}) = _PassengerApiService;

  @GET(ApiConstants.routes)
  Future<List<PassengerRouteModel>> getRoutes();
  @GET(ApiConstants.routeDestinations)
  Future<List<DestinationModel>> getRouteDestinations(
    @Query('from') String from,
  );

  @GET('${ApiConstants.routes}/{routeId}/summary')
  Future<RouteSummaryModel> getRouteSummary(@Path('routeId') String routeId);
  @GET('${ApiConstants.routes}/{routeId}/station-microbuses')
  Future<List<StationMicrobusModel>> getStationMicrobus(
    @Path('routeId') String routeId,
  );

  @GET('${ApiConstants.routes}/{routeId}/on-the-way')
  Future<List<OnTheWayMicrobusModel>> getOnTheWayMicrobuses(
    @Path('routeId') String routeId,
  );
  @POST('${ApiConstants.favoriteRoutes}/{routeId}')
  Future<BaseResponseModel> addRouteToFavorites(
    @Path('routeId') String routeId,
  );
  @DELETE('${ApiConstants.favoriteRoutes}/{routeId}')
  Future<BaseResponseModel> removeRouteFromFavorites(
    @Path('routeId') String routeId,
  );
  @GET(ApiConstants.favoriteRoutes)
  Future<List<FavouriteRouteModel>> getFavoriteRoutes();

  @GET('${ApiConstants.favoriteRoutes}/{routeId}/is-favorite')
  Future<bool> isRouteFavorite(@Path('routeId') String routeId);

  @GET(ApiConstants.reportReasons)
  Future<List<ReportReasonModel>> getReportReasons();

  @POST(ApiConstants.submitReport)
  Future<BaseResponseModel> submitReport(@Body() ReportRequestBodyModel report);
}
