// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_microbus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationMicrobusModel _$StationMicrobusModelFromJson(
  Map<String, dynamic> json,
) => StationMicrobusModel(
  passengerCount: (json['passengerCount'] as num).toInt(),
  model: json['model'] as String,
  color: json['color'] as String,
  driverId: json['driverId'] as String,
  driverName: json['driverName'] as String,
  position: (json['position'] as num).toInt(),
  status: json['status'] as String,
  plateNumber: json['plateNumber'] as String,
);

Map<String, dynamic> _$StationMicrobusModelToJson(
  StationMicrobusModel instance,
) => <String, dynamic>{
  'passengerCount': instance.passengerCount,
  'model': instance.model,
  'color': instance.color,
  'driverId': instance.driverId,
  'driverName': instance.driverName,
  'position': instance.position,
  'status': instance.status,
  'plateNumber': instance.plateNumber,
};
