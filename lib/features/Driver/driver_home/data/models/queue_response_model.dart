// import 'package:json_annotation/json_annotation.dart';
// import '../../domain/entities/queue.dart';
// import 'queue_item_model.dart';

// part 'queue_response_model.g.dart';

// @JsonSerializable(explicitToJson: true)
// class QueueResponseModel {
//   final List<QueueItemModel> items;

//   QueueResponseModel({
//     required this.items,
//   });

//   factory QueueResponseModel.fromJson(List<dynamic> json) {
//     return QueueResponseModel(
//       items: json
//           .map((e) => QueueItemModel.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   QueueResponse toEntity() {
//     return QueueResponse(
//       id: '',
//       stationId: '',
//       routeId: '',
//       items: items.map((e) => e.toEntity()).toList(),
//     );
//   }
// }
