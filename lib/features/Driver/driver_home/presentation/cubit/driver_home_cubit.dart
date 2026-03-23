import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/start_trip_use_case.dart';

import '../../../../../core/auth/token_helper.dart';
import '../../../../../core/auth/token_manager.dart';
import '../../../../../core/config/app_config.dart';
import '../../../../../core/error/failure.dart';
import '../../data/mock/driver_home_mock_data.dart';

import '../../domain/entities/driver_current_status.dart';
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
  Trip? currentTrip;
  List<QueueItem>? queue;
  DriverCurrentStatus? currentStatus;
  Earning? earning;
  // bool positionLoaded = false;

  int totalAmount = 0;

  DateTime? tripFromDate;
  DateTime? tripToDate;

  TripHistoryResponse? tripHistory;

  StreamSubscription? _queueSubscription;

  bool turnNotified = false;

  /// منع تكرار الاتصال
  String? _currentListeningId;
  bool _isConnecting = false;

  /// عدد العناصر في الصفحة
  final int pageSize = 10;

  /// الصفحة الحالية
  int currentPage = 1;

  /// حساب عدد الصفحات
  int get totalPages {
    if (tripHistory == null) return 1;

    final total = tripHistory!.totalCount;
    return (total / pageSize).ceil();
  }

  // ================= CURRENT POSITION =================

  // Future<void> getCurrentPosition() async {
  //   emit(GetCurrentPositionLoading());

  //   final result = await getCurrentPositionUseCase();

  //   result.fold(
  //     (failure) {
  //      if (failure is UnauthorizedFailure) return;
  //       positionLoaded = true;
  //       print("Error loading current position: ${failure.message}");
  //       emit(GetCurrentPositionError(failure.message));
  //     },
  //     (data) async {
  //       positionLoaded = true;

  //       /// 👇 خزّن الحالة كاملة
  //       currentStatus = data;

  //       /// 👇 لو في Queue خزّنها
  //       myPosition = data.queue;
  //       currentTrip = data.trip;

  //       /// 👇 emit الحالة الجديدة
  //       emit(GetCurrentPositionSuccess(data));

  //       /// 👇 لو في Queue بس
  //       if (data.queue != null) {
  //         await listenToQueueNotifications(data.queue!.queueId);
  //         // positionLoaded = true;

  //         await getStationQueue(
  //           driverId: TokenHelper.extractUserId(TokenManager.token ?? '') ?? '',
  //           queueId: data.queue!.queueId,
  //         );
  //       }
  //     },
  //   );
  // }
  Future<void> getCurrentPosition() async {
  emit(GetCurrentPositionLoading());

  final result = await getCurrentPositionUseCase();

  result.fold(
    (failure) {
      if (failure is UnauthorizedFailure) return;

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

  int getMyQueueIndex() {
    if (queue == null || queue!.isEmpty) return -1;

    final myId = TokenManager.userId;

    if (myId == null) return -1;

    final index = queue!.indexWhere((d) => d.driverId == myId);

    return index;
  }

  int getVehiclesAhead() {
    final index = getMyQueueIndex();

    if (index <= 0) return 0;

    return index;
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

    result.fold((failure) => emit(GetStationQueueError(failure.message)), (
      data,
    ) {
      queue = data;
      emit(GetStationQueueSuccess(data));
    });
  }

  // ================= connect Queue Global =================
  Future<void> connectQueueGlobal() async {
    if (_queueSubscription != null) return;

    _queueSubscription = listenToQueueNotificationsUseCase().listen(
      (event) {
        _handleQueueEvent(event);
      },
      onError: (error) {
        emit(ListenQueueNotificationsError(error.toString()));
      },
    );
  }

  // ================= REALTIME QUEUE =================
  Future<void> listenToQueueNotifications(String queueId) async {
    if (_currentListeningId == queueId) return;

    if (_isConnecting) return;

    _isConnecting = true;

    final result = await connectQueue(queueId);

    result.fold(
      (failure) {
        _isConnecting = false;
        emit(ListenQueueNotificationsError(failure.message));
      },
      (_) {
        _currentListeningId = queueId;
        _isConnecting = false;
      },
    );
  }

  void _handleQueueEvent(QueueEvent event) {
    final currentQueue = List<QueueItem>.from(queue ?? []);

    if (event is DriverAddedEvent) {
      currentQueue.removeWhere((d) => d.driverId == event.driver.driverId);
      currentQueue.add(event.driver);

      currentQueue.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));

      if (event.driver.driverId == TokenManager.userId) {
        getCurrentPosition();
        // myPosition = event.driver;
      }
    }

    if (event is DriverRemovedEvent) {
      currentQueue.removeWhere((d) => d.driverId == event.driverId);

      if (event.driverId == TokenManager.userId) {
        myPosition = null;
        getCurrentPosition();
      }
    }

    queue = currentQueue;

    emit(QueueRealtimeUpdated(List.from(queue ?? [])));
  }

  bool isMyTurn() {
    if (queue == null || queue!.isEmpty) return false;

    final myId = TokenManager.userId;

    if (myId == null) return false;

    final firstDriver = queue!.first;

    return firstDriver.driverId == myId;
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

    // if (AppConfig.useMockData) {
    //   await Future.delayed(const Duration(milliseconds: 500));
    //   tripHistory = DriverHomeMockData.tripHistory(pageNumber: currentPage);
    //   totalAmount = tripHistory!.data.totalAmount.toInt();
    //   emit(GetTripHistorySuccess(tripHistory!));
    //   return;
    // }

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

  // ================= CLEAR FILTER =================

  void clearTripFilter() {
    tripFromDate = null;
    tripToDate = null;
    currentPage = 1;

    getTripHistory();
  }

  @override
  Future<void> close() async {
    await _queueSubscription?.cancel();
    return super.close();
  }
}
