import 'package:equatable/equatable.dart';

class RouteTrackingEntity extends Equatable {
  final int numberOfMicrobusesInQueue;
  final int numberOfMicrobusesOnTheWay;
  final int? nearestArrivalMinutes;

  const RouteTrackingEntity({
    required this.numberOfMicrobusesInQueue,
    required this.numberOfMicrobusesOnTheWay,
    this.nearestArrivalMinutes,
  });

  @override
  List<Object?> get props => [
    numberOfMicrobusesInQueue,
    numberOfMicrobusesOnTheWay,
    nearestArrivalMinutes,
  ];
}
