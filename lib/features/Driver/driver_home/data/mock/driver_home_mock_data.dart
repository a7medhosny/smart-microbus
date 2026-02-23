import '../../domain/entities/earning.dart';
import '../../domain/entities/queue.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/trip_history_response.dart';

class DriverHomeMockData {
  // ================= EARNINGS =================

  static Earning get earnings => Earning(
    date: DateTime.now(),
    totalTrips: 12,
    totalPassengers: 87,
    totalDistanceKm: 142.5,
    totalEarnings: 1850,
    currency: "EGP",
    averagePerTrip: 154.2,
    lastUpdated: DateTime.now(),
  );

  // ================= CURRENT POSITION =================

  static QueueItem get currentPosition => QueueItem(
    queueId: "queue_1",
    driverId: "driver_3",
    position: 3,
    status: "Waiting",
    joinedAt: DateTime.now().subtract(const Duration(minutes: 25)),
  );

  // ================= STATION QUEUE =================

  static QueueResponse get stationQueue => QueueResponse(
    id: "queue_1",
    stationId: "station_5",
    routeId: "route_2",
    items: List.generate(
      8,
      (index) => QueueItem(
        queueId: "queue_1",
        driverId: "driver_$index",
        position: index + 1,
        status: index == 0 ? "Loading" : "Waiting",
        joinedAt: DateTime.now().subtract(Duration(minutes: index * 7)),
      ),
    ),
  );

  // ================= TRIPS =================

  static TripHistoryResponse get tripHistory => TripHistoryResponse(
    pageNumber: 1,
    pageSize: 10,
    totalCount: 24,
    data: List.generate(
      10,
      (index) => Trip(
        id: "trip_$index",
        driverId: "driver_123",
        routeId: "route_${index % 3}",
        startedAt: DateTime.now().subtract(Duration(hours: index + 1)),
        endedAt: DateTime.now().subtract(Duration(hours: index)),
        status: "Completed",
      ),
    ),
  );
}
