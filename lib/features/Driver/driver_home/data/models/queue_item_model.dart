import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
part 'queue_item_model.g.dart';

@JsonSerializable()
class QueueItemModel extends QueueItem {
  QueueItemModel({
    required super.queueId,
    required super.driverId,
    required super.position,
    required super.status,
    required super.joinedAt,
  });
  factory QueueItemModel.fromJson(Map<String, dynamic> json) =>
      _$QueueItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$QueueItemModelToJson(this);
}
