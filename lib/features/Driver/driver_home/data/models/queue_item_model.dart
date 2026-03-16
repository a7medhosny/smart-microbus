import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/queue_item.dart';

part 'queue_item_model.g.dart';

@JsonSerializable()
class QueueItemModel {
  final String? queueId;
  final String? driverId;
  final String? driverName;
  final int? position;
  final String? status;
  final int? driversBefore;
  final int? totalDrivers;
  final String? routeFrom;
  final String? routeTo;
  final String? plateNumber;

  const QueueItemModel({
    this.queueId,
    this.driverId,
    this.driverName,
    this.position,
    this.status,
    this.driversBefore,
    this.totalDrivers,
    this.routeFrom,
    this.routeTo,
    this.plateNumber,
  });

  factory QueueItemModel.fromJson(Map<String, dynamic> json) =>
      _$QueueItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$QueueItemModelToJson(this);
}

extension QueueItemMapper on QueueItemModel {
  QueueItem toEntity() {
    return QueueItem(
      queueId: queueId ?? '',
      driverId: driverId ?? '',
      driverName: driverName,
      position: position,
      status: status ?? '',
      driversBefore: driversBefore ?? 0,
      totalDrivers: totalDrivers ?? 0,
      routeFrom: routeFrom,
      routeTo: routeTo,
      plateNumber: plateNumber ?? '',
    );
  }
}
