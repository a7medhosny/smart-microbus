import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/driver_current_status.dart';
import 'driver_trip_model.dart';
import 'queue_item_model.dart';

part 'driver_current_status_model.g.dart';

@JsonSerializable()
class DriverCurrentStatusModel {
  final String driverId;
  final String status;
  final QueueItemModel? queue;
  final DriverTripModel? trip;

  DriverCurrentStatusModel({
    required this.driverId,
    required this.status,
    this.queue,
    this.trip,
  });

  factory DriverCurrentStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DriverCurrentStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverCurrentStatusModelToJson(this);

  DriverCurrentStatus toEntity() {
    return DriverCurrentStatus(
      driverId: driverId,
      status: status,
      queue: queue?.toEntity(),
      trip: trip,
    );
  }
}
