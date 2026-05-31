import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../passener/data/models/base_response_model.dart';

part 'staff_qr_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class StaffQrApiService {
  factory StaffQrApiService(
    Dio dio, {
    String baseUrl,
  }) = _StaffQrApiService;

  @POST(ApiConstants.staffCheckIn)
  Future<BaseResponseModel> checkIn(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.staffCheckOut)
  Future<BaseResponseModel> checkOut(
    @Body() Map<String, dynamic> body,
  );
}