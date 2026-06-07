import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/route_tracking_entity.dart';

part 'route_tracking_model.g.dart';

@JsonSerializable()
class RouteTrackingModel extends RouteTrackingEntity {
  const RouteTrackingModel({
    required super.numberOfMicrobusesInQueue,
    required super.numberOfMicrobusesOnTheWay,
    super.nearestArrivalMinutes,
  });

  factory RouteTrackingModel.fromJson(Map<String, dynamic> json) =>
      _$RouteTrackingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteTrackingModelToJson(this);
}
