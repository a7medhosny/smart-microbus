import 'package:equatable/equatable.dart';
import 'queue_item.dart';

abstract class QueueEvent extends Equatable {
  const QueueEvent();

  @override
  List<Object?> get props => [];
}

class DriverAddedEvent extends QueueEvent {
  final QueueItem driver;

  const DriverAddedEvent(this.driver);

  @override
  List<Object?> get props => [driver];
}

class DriverRemovedEvent extends QueueEvent {
  final String driverId;

  const DriverRemovedEvent(this.driverId);

  @override
  List<Object?> get props => [driverId];
}