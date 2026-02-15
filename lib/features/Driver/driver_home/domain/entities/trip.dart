

class Trip {
  final String id;
  final String driverId;
  final String routeId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String status;

  const Trip({
    required this.id,
    required this.driverId,
    required this.routeId,
    required this.startedAt,
    this.endedAt,
    required this.status,
  });

}
