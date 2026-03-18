class OnTheWayMicrobusEntity {
  final int estimatedArrivalMinutes;
  final int passengerCount;
  final String model;
  final String color;
  final String driverId;
  final String driverName;
  final int position;
  final String status;
  final String plateNumber;

  OnTheWayMicrobusEntity({
    required this.estimatedArrivalMinutes,
    required this.passengerCount,
    required this.model,
    required this.color,
    required this.driverId,
    required this.driverName,
    required this.position,
    required this.status,
    required this.plateNumber,
  });
}
