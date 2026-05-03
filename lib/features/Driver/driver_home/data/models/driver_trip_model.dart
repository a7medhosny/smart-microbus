import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/driver_trip.dart';
part 'driver_trip_model.g.dart';

@JsonSerializable()
class DriverTripModel extends DriverTrip {
  DriverTripModel({
    required super.tripId,
    required super.routeFrom,
    required super.routeTo,
    required super.startedAt,
    required super.distanceKm,
    required super.estimatedArrivalMinutes,
    required super.fromStationId,
    required super.toStationId,
  });
  factory DriverTripModel.fromJson(Map<String, dynamic> json) =>
      _$DriverTripModelFromJson(json);
  Map<String, dynamic> toJson() => _$DriverTripModelToJson(this);
}
