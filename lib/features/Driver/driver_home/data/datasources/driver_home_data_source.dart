import '../models/earning_model.dart';
import '../models/queue_item_model.dart';
import '../models/queue_response_model.dart';
import '../models/trip_history_response_model.dart';

abstract class DriverHomeDataSource {
  Future<QueueItemModel> getCurrentPosition();
  Future<QueueResponseModel> getStationQueue({
    required String stationId,
    required String routeId,
  });
  Future<TripHistoryResponseModel> getTripHistory();
  Future<EarningModel> getEstimatedDailyEarnings();
}
