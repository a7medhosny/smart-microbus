import 'staff_qr_api_service.dart';

abstract class StaffRemoteDataSource {
  Future<void> checkIn(String qrCode);

  Future<void> checkOut(String qrCode);
}

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  final StaffQrApiService apiService;

  StaffRemoteDataSourceImpl(this.apiService);

  @override
  Future<void> checkIn(String qrCode) async {
    await apiService.checkIn({"qrCode": qrCode});
  }

  @override
  Future<void> checkOut(String qrCode) async {
    await apiService.checkOut({"qrCode": qrCode});
  }
}
