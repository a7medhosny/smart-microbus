import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/driver_trip.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/disconnect_queue.dart';

import '../../../../../core/auth/token_helper.dart';
import '../../../../../core/auth/token_manager.dart';
import '../../../../../core/config/app_config.dart';
import '../../../../../core/storage/cache_helper.dart';
import '../../../../../core/storage/cache_keys.dart';

import '../../data/mock/driver_home_mock_data.dart';

import '../../domain/entities/dashboard_event.dart';
import '../../domain/entities/driver_current_status.dart';
import '../../domain/entities/earning.dart';
import '../../domain/entities/queue_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/trip_history_response.dart';

import '../../domain/usecases/connect_dashboard_use_case.dart';
import '../../domain/usecases/connect_queue.dart';
import '../../domain/usecases/end_trip_use_case.dart';
import '../../domain/usecases/get_current_position_use_case.dart';
import '../../domain/usecases/get_estimated_daily_earnings_use_case.dart';
import '../../domain/usecases/get_station_queue_use_case.dart';
import '../../domain/usecases/get_trip_history_use_case.dart';
import '../../domain/usecases/listen_to_dashboard_notifications_use_case.dart';
import '../../domain/usecases/listen_to_queue_notifications_use_case.dart';
import '../../domain/usecases/start_trip_use_case.dart';

part 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  // ================= USE CASES =================
  final GetCurrentPositionUsecase getCurrentPositionUseCase;
  final GetEstimatedDailyEarningsUseCase getEstimatedDailyEarningsUseCase;
  final GetStationQueueUseCase getStationQueueUseCase;
  final GetTripHistoryUseCase getTripHistoryUseCase;
  final ListenToQueueNotificationsUseCase listenToQueueNotificationsUseCase;
  final ListenToDashboardNotificationsUseCase
  listenToDashboardNotificationsUseCase;
  final ConnectQueue connectQueue;
  final ConnectDashboardUseCase connectDashboardUseCase;
  final StartTripUseCase startTripUseCase;
  final EndTripUseCase endTripUseCase;
  final DisconnectQueue disconnectQueue;

  DriverHomeCubit(
    this.getCurrentPositionUseCase,
    this.getEstimatedDailyEarningsUseCase,
    this.getStationQueueUseCase,
    this.getTripHistoryUseCase,
    this.listenToQueueNotificationsUseCase,
    this.listenToDashboardNotificationsUseCase,
    this.connectQueue,
    this.connectDashboardUseCase,
    this.startTripUseCase,
    this.endTripUseCase,
    this.disconnectQueue,
  ) : super(DriverHomeInitial());

  // ================= STATE DATA =================
  QueueItem? myPosition;
  DriverTrip? currentTrip;
  List<QueueItem>? queue;
  DriverCurrentStatus? currentStatus;
  Earning? earning;
  TripHistoryResponse? tripHistory;
  bool turnNotified = false;
  int totalAmount = 0;

  DateTime? tripToDate = DateTime.now();
  DateTime? tripFromDate = DateTime.now().subtract(const Duration(days: 7));

  // ================= PAGINATION =================
  final int pageSize = 10;
  int currentPage = 1;

  String? lang = CacheHelper.getCacheData(key: CacheKeys.localeKey);

  int get totalPages {
    if (tripHistory == null) return 1;
    return (tripHistory!.totalCount / pageSize).ceil();
  }

  // ================= NAVIGATION =================
  int currentNavIndex = 0;

  final List<GlobalKey<NavigatorState>> navKeys = List.generate(
    3,
    (_) => GlobalKey<NavigatorState>(),
  );

  void changeBottomNavIndex(int index) {
    currentNavIndex = index;

    if (lang != CacheHelper.getCacheData(key: CacheKeys.localeKey)) {
      lang = CacheHelper.getCacheData(key: CacheKeys.localeKey);
      getCurrentPosition();
      getTripHistory();
    }

    emit(ChangeDriverBottomNavState(index));
  }

  // ================= STREAM =================
  StreamSubscription? _queueSubscription;
  StreamSubscription? _dashboardSubscription;

  String? _currentListeningId;
  bool _isConnecting = false;

  // ================= INIT =================
  Future<void> initRealtime() async {
    await connectDashboardGlobal();
    // await connectQueueGlobal();
  }

  // ================= CURRENT POSITION =================
  Future<void> getCurrentPosition() async {
    emit(GetCurrentPositionLoading());

    final result = await getCurrentPositionUseCase();

    result.fold(
      (failure) {
        if (failure.runtimeType.toString() == "UnauthorizedFailure") return;
        emit(GetCurrentPositionError(failure.message));
      },
      (data) async {
        currentStatus = data;
        myPosition = data.queue;
        currentTrip = data.trip;

        emit(GetCurrentPositionSuccess(data));

        if (data.queue != null) {
          await listenToQueueNotifications(data.queue!.queueId);

          await getStationQueue(
            driverId: TokenHelper.extractUserId(TokenManager.token ?? '') ?? '',
            queueId: data.queue!.queueId,
          );
        }
      },
    );
  }

  // ================= QUEUE HELPERS =================
  int getMyQueueIndex() {
    if (queue == null || queue!.isEmpty) return -1;

    final myId = TokenManager.userId;
    if (myId == null) return -1;

    return queue!.indexWhere((d) => d.driverId == myId);
  }

  int getVehiclesAhead() {
    final index = getMyQueueIndex();
    return index <= 0 ? 0 : index;
  }

  bool isMyTurn() {
    if (queue == null || queue!.isEmpty) return false;

    final myId = TokenManager.userId;
    if (myId == null) return false;

    return queue!.first.driverId == myId;
  }

  // ================= DAILY EARNINGS =================
  Future<void> getEstimatedDailyEarnings() async {
    emit(GetDailyEarningsLoading());

    if (AppConfig.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      earning = DriverHomeMockData.earnings;
      emit(GetDailyEarningsSuccess(earning!));
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

    result.fold((failure) => emit(GetStationQueueError(failure.message)), (
      data,
    ) {
      queue = data;
      emit(GetStationQueueSuccess(data));
    });
  }

  // ================= REALTIME QUEUE =================
  Future<void> listenToQueueNotifications(String queueId) async {
    if (_currentListeningId == queueId && _queueSubscription != null) return;
    if (_isConnecting) return;

    print("🔌 Connecting + Listening to Queue: $queueId");

    // 🧹 clean old
    await _queueSubscription?.cancel();
    _queueSubscription = null;
    _currentListeningId = null;

    _isConnecting = true;

    final result = await connectQueue(queueId);

    result.fold(
      (failure) {
        _isConnecting = false;
        emit(ListenQueueNotificationsError(failure.message));
      },
      (_) {
        _isConnecting = false;
        _currentListeningId = queueId;

        _queueSubscription = listenToQueueNotificationsUseCase().listen(
          _handleQueueEvent,
          onError: (error) =>
              emit(ListenQueueNotificationsError(error.toString())),
        );

        print("✅ Queue listening started");
      },
    );
  }

  void _handleQueueEvent(QueueEvent event) {
    final currentQueue = List<QueueItem>.from(queue ?? []);

    if (event is DriverAddedEvent) {
      currentQueue.removeWhere((d) => d.driverId == event.driver.driverId);
      currentQueue.add(event.driver);

      currentQueue.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));

      // if (event.driver.driverId == TokenManager.userId) {
      //   getCurrentPosition();
      // }
    }

    if (event is DriverRemovedEvent) {
      print("🚫 Driver removed from queue: ${event.driverId}");
      currentQueue.removeWhere((d) => d.driverId == event.driverId);

      // if (event.driverId == TokenManager.userId) {
      //   myPosition = null;
      //   getCurrentPosition();
      // }
    }

    queue = currentQueue;
    emit(QueueRealtimeUpdated(List.from(queue!)));
  }

  Future<void> _disconnectQueueCompletely() async {
    try {
      await disconnectQueue();

      await _queueSubscription?.cancel();
      _queueSubscription = null;

      _currentListeningId = null;
      queue = null;

      print("✅ Queue disconnected بالكامل");
    } catch (e) {
      print("❌ Error while disconnecting queue: $e");
    }
  }

  // ================= REALTIME DASHBOARD =================
  Future<void> connectDashboardGlobal() async {
    if (_dashboardSubscription != null) return;

    final result = await connectDashboardUseCase();

    result.fold(
      (failure) => emit(ListenQueueNotificationsError(failure.message)),
      (_) {
        _dashboardSubscription = listenToDashboardNotificationsUseCase().listen(
          _handleDashboardEvent,
          onError: (error) =>
              emit(ListenQueueNotificationsError(error.toString())),
        );
      },
    );
  }

  Future<void> _handleDashboardEvent(DashboardEvent event) async {
    if (event is DashboardUpdatedEvent) {
      final status = event.data.status;
      final data = event.data;

      print("📊 Dashboard Status: $status");

      // ✅ لو دخل في رحلة
      if (status == "OnTrip") {
        print("🚗 Driver is OnTrip → Disconnecting Queue...");

        _disconnectQueueCompletely();
      }
      currentStatus = data;
      myPosition = data.queue;
      currentTrip = data.trip;

      emit(GetCurrentPositionSuccess(data));

      if (data.queue != null) {
        await listenToQueueNotifications(data.queue!.queueId);

        await getStationQueue(
          driverId: TokenHelper.extractUserId(TokenManager.token ?? '') ?? '',
          queueId: data.queue!.queueId,
        );
      }

      // getCurrentPosition();
    }
  }

  // ================= TRIP HISTORY =================
  Future<void> getTripHistory({
    DateTime? fromDate,
    DateTime? toDate,
    int? pageNumber,
  }) async {
    tripFromDate = fromDate ?? tripFromDate;
    tripToDate = toDate ?? tripToDate;
    currentPage = pageNumber ?? currentPage;

    emit(GetTripHistoryLoading());

    final result = await getTripHistoryUseCase(
      fromDate: tripFromDate,
      toDate: tripToDate,
      pageSize: pageSize,
      pageNumber: currentPage,
    );

    result.fold(
      (failure) {
        if (failure.message.contains("No trips found")) {
          tripHistory = TripHistoryResponse.empty();
          totalAmount = 0;
          emit(GetTripHistorySuccess(tripHistory!));
        } else {
          emit(GetTripHistoryError(failure.message));
        }
      },
      (data) {
        tripHistory = data;
        totalAmount = data.data.totalAmount.toInt();
        emit(GetTripHistorySuccess(data));
      },
    );
  }

  void clearTripFilter() {
    tripFromDate = null;
    tripToDate = null;
    currentPage = 1;

    getTripHistory();
  }

  // ================= CLOSE =================
  @override
  Future<void> close() async {
    await _queueSubscription?.cancel();
    await _dashboardSubscription?.cancel();
    return super.close();
  }
}
