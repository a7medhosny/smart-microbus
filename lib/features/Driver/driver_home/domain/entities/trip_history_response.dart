import 'trip.dart';

class TripHistoryResponse {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final TripHistoryData data;

  TripHistoryResponse({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.data,
  });
  factory TripHistoryResponse.empty() {
    return TripHistoryResponse(
      pageNumber: 1,
      pageSize: 0,
      totalCount: 0,
      data: TripHistoryData.empty(),
    );
  }
}

class TripHistoryData {
  final double totalAmount;
  final List<Trip> trips;

  TripHistoryData({required this.totalAmount, required this.trips});
  factory TripHistoryData.empty() {
    return TripHistoryData(totalAmount: 0, trips: []);
  }
}
