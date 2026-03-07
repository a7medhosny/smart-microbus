class QueueItem {
  final String queueId;
  final String driverId;
  final String? driverName;
  final int position;
  final String status;
  final int driversBefore;
  final int totalDrivers;
  final String? routeFrom;
  final String? routeTo;

  const QueueItem({
    required this.queueId,
    required this.driverId,
    this.driverName,
    required this.position,
    required this.status,
    required this.driversBefore,
    required this.totalDrivers,
    this.routeFrom,
    this.routeTo,
  });
}