import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripModel extends Trip {
  TripModel({
    required super.id,
    required super.driverId,
    required super.routeId,
    required super.startedAt,
    required super.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}
