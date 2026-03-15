
import '../../domain/entities/queue_event.dart';

abstract class QueueSignalRDataSource {
  Future<void> connect(String queueId);
  Future<void> disconnect();

 Stream<QueueEvent> get queueEvents;
}