import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';

part 'staff_qr_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class StaffQrApiService {
  factory StaffQrApiService(
    Dio dio, {
    String baseUrl,
  }) = _StaffQrApiService;

  @POST(ApiConstants.staffCheckIn)
  Future<void> checkIn(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.staffCheckOut)
  Future<void> checkOut(
    @Body() Map<String, dynamic> body,
  );
}