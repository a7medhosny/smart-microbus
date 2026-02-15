import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/networking/api_constants.dart';

part 'driver_home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DriverHomeApiService {
  factory DriverHomeApiService(Dio dio, {String baseUrl}) =
      _DriverHomeApiService;
}
