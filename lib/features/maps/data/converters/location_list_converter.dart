import 'package:json_annotation/json_annotation.dart';

import '../models/location_model.dart';

class LocationListConverter
    implements JsonConverter<List<LocationModel>, List<dynamic>> {
  const LocationListConverter();

  @override
  List<LocationModel> fromJson(List<dynamic> json) {
    return json.map((e) => LocationModel.fromList(e as List<dynamic>)).toList();
  }

  @override
  List<dynamic> toJson(List<LocationModel> object) {
    return object.map((e) => [e.latitude, e.longitude]).toList();
  }
}
