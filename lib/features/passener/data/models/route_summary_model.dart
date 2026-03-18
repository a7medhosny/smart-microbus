import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/route_summary_entity.dart';
part 'route_summary_model.g.dart';

@JsonSerializable()
class RouteSummaryModel extends RouteSummaryEntity {
  RouteSummaryModel({
    required super.price,
    required super.distanceKm,
    required super.numberOfMicrobusesInQueue,
    required super.numberOfMicrobusesOnTheWay,
    required super.nearestArrivalMinutes,
  });
  factory RouteSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$RouteSummaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$RouteSummaryModelToJson(this);
}
