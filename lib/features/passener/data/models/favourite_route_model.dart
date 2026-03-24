import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/favourite_route_entity.dart';
part 'favourite_route_model.g.dart';

@JsonSerializable()
class FavouriteRouteModel extends FavouriteRouteEntity {
  FavouriteRouteModel({
    required super.id,
    required super.routeId,
    required super.from,
    required super.to,
    required super.price,
  });
  factory FavouriteRouteModel.fromJson(Map<String, dynamic> json) =>
      _$FavouriteRouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteRouteModelToJson(this);
}
