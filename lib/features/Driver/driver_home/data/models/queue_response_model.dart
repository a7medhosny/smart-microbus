import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/queue.dart';
import 'queue_item_model.dart';

part 'queue_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QueueResponseModel {
  final String id;
  final String stationId;
  final String routeId;
  final List<QueueItemModel> items;

  QueueResponseModel({
    required this.id,
    required this.stationId,
    required this.routeId,
    required this.items,
  });

  factory QueueResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QueueResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QueueResponseModelToJson(this);

  QueueResponse toEntity() {
    return QueueResponse(
      id: id,
      stationId: stationId,
      routeId: routeId,
      items: items,
    );
  }

  factory QueueResponseModel.fromEntity(QueueResponse entity) {
    return QueueResponseModel(
      id: entity.id,
      stationId: entity.stationId,
      routeId: entity.routeId,
      items: entity.items
          .map(
            (item) => QueueItemModel(
              queueId: item.queueId,
              driverId: item.driverId,
              position: item.position,
              status: item.status,
              joinedAt: item.joinedAt,
            ),
          )
          .toList(),
    );
  }
}
