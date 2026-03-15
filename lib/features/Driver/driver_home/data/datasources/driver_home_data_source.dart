import '../models/earning_model.dart';
import '../models/queue_item_model.dart';
import '../models/trip_history_response_model.dart';

abstract class DriverHomeDataSource {
  Future<QueueItemModel> getCurrentPosition();
  Future<List<QueueItemModel>> getStationQueue({
    required String driverId,
    // required String stationId,
    // required String routeId,
  });
  Future<TripHistoryResponseModel> getTripHistory({
    DateTime? fromDate,
    DateTime? toDate,
    int? pageSize,
    int? pageNumber,
  });
  Future<EarningModel> getEstimatedDailyEarnings();
  Future<void> startTrip({required String driverId});
  Future<void> endTrip({required String driverId});
}
