import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/trip_history_response.dart';
import 'trip_history_data_model.dart';

part 'trip_history_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TripHistoryResponseModel {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final TripHistoryDataModel data;

  TripHistoryResponseModel({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.data,
  });

  factory TripHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TripHistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripHistoryResponseModelToJson(this);

  TripHistoryResponse toEntity() {
    return TripHistoryResponse(
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalCount: totalCount,
      data: TripHistoryData(totalAmount: data.totalAmount, trips: data.trips),
    );
  }
}
