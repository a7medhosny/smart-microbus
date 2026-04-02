
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/trip.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripModel extends Trip {
  TripModel({
    required super.amount,
    required super.routeFrom,
    required super.routeTo,
    required super.startedAt,
    required super.endedAt,
    required super.passengerCount,
    required super.distance,
    required int status,
    required super.estimatedArrivalMinutes,
  }) : super(
         status: status.toString(),
       );

factory TripModel.fromJson(Map<String, dynamic> json) {
  return TripModel(
    amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    routeFrom: json['routeFrom'] ?? '',
    routeTo: json['routeTo'] ?? '',

    startedAt: _parseDate(json['startedAt']),
    endedAt: _parseDate(json['endedAt']),

    passengerCount: json['passengerCount'] ?? 0,
    distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
    status: json['status'] ?? 0,
    estimatedArrivalMinutes:
        (json['estimatedArrivalMinutes'] as num?)?.toDouble() ?? 0.0,
  );
}

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}

DateTime _parseDate(String? value) {
  if (value == null || value.trim().isEmpty) {
    return DateTime.now();
  }

  try {
    return DateFormat('yyyy MM dd HH:mm').parse(value.trim());
  } catch (e) {
    print("DATE PARSE ERROR: $value");
    return DateTime.now();
  }
}