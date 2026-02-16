import 'package:smart_microbus/features/Driver/driver_home/data/datasources/driver_home_data_source.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/earning_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/queue_item_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/queue_response_model.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/models/trip_history_response_model.dart';

import 'driver_home_api_service.dart';

class DriverHomeDataSourceImpl implements DriverHomeDataSource {
  final DriverHomeApiService apiService;

  DriverHomeDataSourceImpl(this.apiService);
  @override
  Future<QueueItemModel> getCurrentPosition() {
    return apiService.getCurrentPosition();
  }

  @override
  Future<EarningModel> getEstimatedDailyEarnings() {
    return apiService.getEstimatedDailyEarnings();
  }

  @override
  Future<QueueResponseModel> getStationQueue({
    required String stationId,
    required String routeId,
  }) {
    return apiService.getStationQueue(stationId: stationId, routeId: routeId);
  }

  @override
  Future<TripHistoryResponseModel> getTripHistory() {
    return apiService.getTripHistory();
  }
}
