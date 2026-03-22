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
    driversBefore: 2,
    totalDrivers: 5,
    plateNumber: '',
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
        driversBefore: 0,
        totalDrivers: 1,
        plateNumber: '',
      ),
    ),
  );

  // ================= TRIPS =================

  static TripHistoryResponse tripHistory({int pageNumber = 1}) {
    const int pageSize = 10;
    const int totalCount = 104;

    /// حساب البداية والنهاية للـ pagination
    final startIndex = (pageNumber - 1) * pageSize;
    final endIndex = (startIndex + pageSize) > totalCount
        ? totalCount
        : startIndex + pageSize;

    final trips = List.generate(endIndex - startIndex, (index) {
      final i = startIndex + index;

      return Trip(
        startedAt: DateTime.now().subtract(Duration(hours: i + 1)),
        endedAt: DateTime.now().subtract(Duration(hours: i)),
        status: "Completed",
        amount: 800,
        routeFrom: 'Minia',
        routeTo: 'Bani mazar',
        passengerCount: 40,
        distance: 800,
        estimatedArrivalMinutes: 45,
      );
    });

    return TripHistoryResponse(
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      data: TripHistoryData(totalAmount: trips.length * 800, trips: trips),
    );
  }
}
