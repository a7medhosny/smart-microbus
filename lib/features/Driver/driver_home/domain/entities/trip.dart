class Trip {
  final double amount;
  final String routeFrom;
  final String routeTo;
  final DateTime startedAt;
  final DateTime endedAt;
  final int passengerCount;
  final double distance;
  final double estimatedArrivalMinutes;
  final String status;
  

  Trip({
    required this.amount,
    required this.routeFrom,
    required this.routeTo,
    required this.startedAt,
    required this.endedAt,
    required this.passengerCount,
    required this.distance,
    required this.status,
    required this.estimatedArrivalMinutes,
  });
}
