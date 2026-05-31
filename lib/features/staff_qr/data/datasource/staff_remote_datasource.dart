import '../../../passener/data/models/base_response_model.dart';
import 'staff_qr_api_service.dart';

abstract class StaffRemoteDataSource {
  Future<BaseResponseModel> checkIn(String qrCode);

  Future<BaseResponseModel> checkOut(String qrCode);
}

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  final StaffQrApiService apiService;

  StaffRemoteDataSourceImpl(this.apiService);

  @override
  Future<BaseResponseModel> checkIn(String qrCode) async {
    return await apiService.checkIn({"qrCode": qrCode});
  }

  @override
  Future<BaseResponseModel> checkOut(String qrCode) async {
    return await apiService.checkOut({"qrCode": qrCode});
  }
}
