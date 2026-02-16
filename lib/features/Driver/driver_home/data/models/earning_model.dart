import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/earning.dart';
part 'earning_model.g.dart';

@JsonSerializable()
class EarningModel extends Earning {
  EarningModel({
    required super.date,
    required super.totalTrips,
    required super.totalPassengers,
    required super.totalDistanceKm,
    required super.totalEarnings,
    required super.currency,
    required super.averagePerTrip,
    required super.lastUpdated,
  });
  factory EarningModel.fromJson(Map<String, dynamic> json) =>
      _$EarningModelFromJson(json);
  Map<String, dynamic> toJson() => _$EarningModelToJson(this);
}
