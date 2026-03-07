import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/start_trip_use_case.dart';

import '../../../../../core/auth/token_helper.dart';
import '../../../../../core/auth/token_manager.dart';
import '../../../../../core/config/app_config.dart';
import '../../data/mock/driver_home_mock_data.dart';

import '../../domain/entities/earning.dart';
import '../../domain/entities/queue_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/trip_history_response.dart';

import '../../domain/usecases/end_trip_use_case.dart';
import '../../domain/usecases/get_current_position_use_case.dart';
import '../../domain/usecases/get_estimated_daily_earnings_use_case.dart';
import '../../domain/usecases/get_station_queue_use_case.dart';
import '../../domain/usecases/get_trip_history_use_case.dart';
import '../../domain/usecases/listen_to_queue_notifications_use_case.dart';
import '../../domain/usecases/connect_queue.dart';

part 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final GetCurrentPositionUsecase getCurrentPositionUseCase;
  final GetEstimatedDailyEarningsUseCase getEstimatedDailyEarningsUseCase;
  final GetStationQueueUseCase getStationQueueUseCase;
  final GetTripHistoryUseCase getTripHistoryUseCase;
  final ListenToQueueNotificationsUseCase listenToQueueNotificationsUseCase;
  final ConnectQueue connectQueue;
  final StartTripUseCase startTripUseCase;
  final EndTripUseCase endTripUseCase;

  DriverHomeCubit(
    this.getCurrentPositionUseCase,
    this.getEstimatedDailyEarningsUseCase,
    this.getStationQueueUseCase,
    this.getTripHistoryUseCase,
    this.listenToQueueNotificationsUseCase,
    this.connectQueue,
    this.startTripUseCase,
    this.endTripUseCase,
  ) : super(DriverHomeInitial());

  QueueItem? myPosition;
  List<QueueItem>? queue;
  Earning? earning;

  StreamSubscription? _queueSubscription;

  // ================= CURRENT POSITION =================

Future<void> getCurrentPosition() async {
  emit(GetCurrentPositionLoading());

  final result = await getCurrentPositionUseCase();

  result.fold(
    (failure) => emit(GetCurrentPositionError(failure.message)),
    (data) async {
      myPosition = data;

      emit(GetCurrentPositionSuccess(data));

      /// استدعاء الكيو بعد ما نعرف ال queueId
      await getStationQueue(
        driverId: TokenHelper.extractUserId(TokenManager.token ?? '') ?? '',
        queueId: data.queueId,
      );
    },
  );
}

  // ================= DAILY EARNINGS =================

  Future<void> getEstimatedDailyEarnings() async {
    emit(GetDailyEarningsLoading());

    if (AppConfig.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      earning = DriverHomeMockData.earnings;
      emit(GetDailyEarningsSuccess(DriverHomeMockData.earnings));
      return;
    }

    final result = await getEstimatedDailyEarningsUseCase();

    result.fold(
      (failure) => emit(GetDailyEarningsError(failure.message)),
      (data) => emit(GetDailyEarningsSuccess(data)),
    );
  }

  // ================= STATION QUEUE =================

  Future<void> getStationQueue({
    required String driverId,
    required String queueId,
  }) async {
    emit(GetStationQueueLoading());

    final result = await getStationQueueUseCase(driverId: driverId);

    result.fold(
      (failure) => emit(GetStationQueueError(failure.message)),
      (data) async {
        queue = data;

        emit(GetStationQueueSuccess(data));

        /// تشغيل realtime
        await listenToQueueNotifications(queueId);
      },
    );
  }

  // ================= REALTIME QUEUE =================

  Future<void> listenToQueueNotifications(String queueId) async {
    emit(ListenQueueNotificationsLoading());

    /// الاتصال بالـ SignalR
    final result = await connectQueue(queueId);

    result.fold(
      (failure) {
        emit(ListenQueueNotificationsError(failure.message));
        return;
      },
      (_) {},
    );

    await _queueSubscription?.cancel();

    _queueSubscription = listenToQueueNotificationsUseCase().listen(
      (event) {
        _handleQueueEvent(event);
      },
      onError: (error) {
        emit(ListenQueueNotificationsError(error.toString()));
      },
    );
  }

  // ================= HANDLE EVENTS =================

  void _handleQueueEvent(QueueEvent event) {
    if (queue == null) return;

    if (event is DriverAddedEvent) {
      queue = [
        ...queue!.where((d) => d.driverId != event.driver.driverId),
        event.driver
      ];
    }

    if (event is DriverRemovedEvent) {
      queue = queue!.where((d) => d.driverId != event.driverId).toList();
    }

    emit(QueueRealtimeUpdated(queue!));
  }

  // ================= TRIP HISTORY =================

  Future<void> getTripHistory() async {
    emit(GetTripHistoryLoading());

    final result = await getTripHistoryUseCase();

    result.fold(
      (failure) => emit(GetTripHistoryError(failure.message)),
      (data) => emit(GetTripHistorySuccess(data)),
    );
  }

  // ================= START TRIP =================

  Future<void> startTrip({required String driverId}) async {
    emit(StartTripLoading());

    final result = await startTripUseCase(driverId: driverId);

    result.fold(
      (failure) => emit(StartTripError(failure.message)),
      (_) => emit(StartTripSuccess()),
    );
  }

  // ================= END TRIP =================

  Future<void> endTrip({required String driverId}) async {
    emit(EndTripLoading());

    final result = await endTripUseCase(driverId: driverId);

    result.fold(
      (failure) => emit(EndTripError(failure.message)),
      (_) => emit(EndTripSuccess()),
    );
  }

  // ================= CLOSE =================

  @override
  Future<void> close() async {
    await _queueSubscription?.cancel();
    return super.close();
  }
}