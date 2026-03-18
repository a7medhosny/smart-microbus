// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_the_way_microbus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnTheWayMicrobusModel _$OnTheWayMicrobusModelFromJson(
  Map<String, dynamic> json,
) => OnTheWayMicrobusModel(
  estimatedArrivalMinutes: (json['estimatedArrivalMinutes'] as num).toInt(),
  passengerCount: (json['passengerCount'] as num).toInt(),
  model: json['model'] as String,
  color: json['color'] as String,
  driverId: json['driverId'] as String,
  driverName: json['driverName'] as String,
  position: (json['position'] as num).toInt(),
  status: json['status'] as String,
  plateNumber: json['plateNumber'] as String,
);

Map<String, dynamic> _$OnTheWayMicrobusModelToJson(
  OnTheWayMicrobusModel instance,
) => <String, dynamic>{
  'estimatedArrivalMinutes': instance.estimatedArrivalMinutes,
  'passengerCount': instance.passengerCount,
  'model': instance.model,
  'color': instance.color,
  'driverId': instance.driverId,
  'driverName': instance.driverName,
  'position': instance.position,
  'status': instance.status,
  'plateNumber': instance.plateNumber,
};
