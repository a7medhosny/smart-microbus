class QueueItem {
  final String queueId;
  final String stationId;
  final String driverId;
  final String routeId;
  final int position;
  final String status;
  final DateTime joinedAt;

  const QueueItem({
    required this.queueId,
    required this.driverId,
    required this.position,
    required this.status,
    required this.joinedAt,
    required this.stationId,
    required this.routeId,
  });
}
