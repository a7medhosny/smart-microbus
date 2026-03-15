// import 'package:json_annotation/json_annotation.dart';
// import '../../domain/entities/trip.dart';

// part 'trip_model.g.dart';

// @JsonSerializable()
// class TripModel extends Trip {
//   TripModel({
//     required double amount,
//     required String routeFrom,
//     required String routeTo,
//     required DateTime startedAt,
//     required DateTime endedAt,
//     required int passengerCount,
//     required double distance,
//     required int status,
//   }) : super(
//          amount: amount,
//          routeFrom: routeFrom,
//          routeTo: routeTo,
//          startedAt: startedAt,
//          endedAt: endedAt,
//          passengerCount: passengerCount,
//          distance: distance,
//          status: status.toString(),
//        );

//   factory TripModel.fromJson(Map<String, dynamic> json) =>
//       _$TripModelFromJson(json);

//   Map<String, dynamic> toJson() => _$TripModelToJson(this);
// }
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/trip.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripModel extends Trip {
  TripModel({
    required double amount,
    required String routeFrom,
    required String routeTo,
    required DateTime startedAt,
    required DateTime endedAt,
    required int passengerCount,
    required double distance,
    required int status,
  }) : super(
         amount: amount,
         routeFrom: routeFrom,
         routeTo: routeTo,
         startedAt: startedAt,
         endedAt: endedAt,
         passengerCount: passengerCount,
         distance: distance,
         status: status.toString(),
       );

  factory TripModel.fromJson(Map<String, dynamic> json) {
    final formatter = DateFormat("yyyy MM dd HH:mm");

    return TripModel(
      amount: (json['amount'] as num).toDouble(),
      routeFrom: json['routeFrom'],
      routeTo: json['routeTo'],
      startedAt: formatter.parse(json['startedAt']),
      endedAt: formatter.parse(json['endedAt']),
      passengerCount: json['passengerCount'],
      distance: (json['distance'] as num).toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}
