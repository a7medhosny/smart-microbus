import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip.dart';

class TripHistoryResponse {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final List<Trip> data;

  TripHistoryResponse({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.data,
  });
}
