import 'package:intl/intl.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/datasources/driver_home_data_source.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/earning_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/queue_item_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/trip_history_response_model.dart';

import '../models/driver_current_status_model.dart';
import 'driver_home_api_service.dart';

class DriverHomeDataSourceImpl implements DriverHomeDataSource {
  final DriverHomeApiService apiService;

  DriverHomeDataSourceImpl(this.apiService);
  @override
  Future<DriverCurrentStatusModel> getCurrentPosition() {
    return apiService.getCurrentPosition();
  }

  @override
  Future<TripHistoryResponseModel> getTripHistory({
    DateTime? fromDate,
    DateTime? toDate,
    int? pageSize,
    int? pageNumber,
  }) {
    final formatter = DateFormat('yyyy-M-d');

    return apiService.getTripHistory(
      fromDate: fromDate != null ? formatter.format(fromDate) : null,
      toDate: toDate != null ? formatter.format(toDate) : null,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
  }

  @override
  Future<EarningModel> getEstimatedDailyEarnings() {
    return apiService.getEstimatedDailyEarnings();
  }

  @override
  Future<List<QueueItemModel>> getStationQueue({
    required String driverId,

  }) {
    return apiService.getStationQueue(driverId: driverId);
  }

  @override
  Future<void> startTrip({required String driverId}) {
    return apiService.startTrip(driverId: driverId);
  }

  @override
  Future<void> endTrip({required String driverId}) {
    return apiService.endTrip(driverId: driverId);
  }
}
