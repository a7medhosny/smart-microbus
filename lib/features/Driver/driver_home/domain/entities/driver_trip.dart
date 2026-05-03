class DriverTrip {
  final String tripId;
  final String routeFrom;
  final String routeTo;
  final DateTime startedAt;
  final double distanceKm;
  final double estimatedArrivalMinutes;
  final String fromStationId;
  final String toStationId;

  DriverTrip({
    required this.tripId,
    required this.routeFrom,
    required this.routeTo,
    required this.startedAt,
    required this.distanceKm,
    required this.estimatedArrivalMinutes,
    required this.fromStationId,
    required this.toStationId,
  });
}
