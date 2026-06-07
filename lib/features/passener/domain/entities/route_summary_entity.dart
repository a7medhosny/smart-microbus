class RouteSummaryEntity {
  final double price;
  final double distanceKm;
  final int numberOfMicrobusesInQueue;
  final int numberOfMicrobusesOnTheWay;
  final int? nearestArrivalMinutes;


  RouteSummaryEntity({
    required this.price,
    required this.distanceKm,
    required this.numberOfMicrobusesInQueue,
    required this.numberOfMicrobusesOnTheWay,
    this.nearestArrivalMinutes,
  });
}
