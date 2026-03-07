import 'package:smart_microbus/features/Driver/driver_home/data/models/driver_model.dart';

import '../../domain/entities/queue_event.dart';

abstract class QueueSignalRDataSource {
  Future<void> connect(String queueId);
  Future<void> disconnect();

 Stream<QueueEvent> get queueEvents;
}