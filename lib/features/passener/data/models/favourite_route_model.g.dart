// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteRouteModel _$FavouriteRouteModelFromJson(Map<String, dynamic> json) =>
    FavouriteRouteModel(
      id: json['id'] as String,
      routeId: json['routeId'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$FavouriteRouteModelToJson(
  FavouriteRouteModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'routeId': instance.routeId,
  'from': instance.from,
  'to': instance.to,
  'price': instance.price,
};
