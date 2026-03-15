import 'package:json_annotation/json_annotation.dart';
import 'trip_model.dart';

part 'trip_history_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TripHistoryDataModel {
  final double totalAmount;
  final List<TripModel> trips;

  TripHistoryDataModel({required this.totalAmount, required this.trips});

  factory TripHistoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$TripHistoryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripHistoryDataModelToJson(this);
}
