import 'queue_item.dart';
import 'trip.dart';

class DriverCurrentStatus {
  final String driverId;
  final String status;
  final QueueItem? queue;
  final Trip? trip;

  DriverCurrentStatus({
    required this.driverId,
    required this.status,
    this.queue,
    this.trip,
  });
}

extension DriverStatusX on DriverCurrentStatus {
  bool get isOnTrip => trip != null;
  bool get isInQueue => queue != null && trip == null;
  bool get isAvailable => trip == null && queue == null;
}