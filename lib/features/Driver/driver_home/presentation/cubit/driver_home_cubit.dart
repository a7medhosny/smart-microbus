import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/config/app_config.dart';
import '../../data/mock/driver_home_mock_data.dart';
import '../../domain/entities/earning.dart';
import '../../domain/entities/queue.dart';
import '../../domain/entities/queue_event.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/trip_history_response.dart';

import '../../domain/usecases/get_current_position_use_case.dart';
import '../../domain/usecases/get_estimated_daily_earnings_use_case.dart';
import '../../domain/usecases/get_station_queue_use_case.dart';
import '../../domain/usecases/get_trip_history_use_case.dart';
import '../../domain/usecases/listen_to_queue_notifications_use_case.dart';

part 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final GetCurrentPositionUsecase getCurrentPositionUseCase;
  final GetEstimatedDailyEarningsUseCase getEstimatedDailyEarningsUseCase;
  final GetStationQueueUseCase getStationQueueUseCase;
  final GetTripHistoryUseCase getTripHistoryUseCase;
  final ListenToQueueNotificationsUseCase listenToQueueNotificationsUseCase;

  DriverHomeCubit(
    this.getCurrentPositionUseCase,
    this.getEstimatedDailyEarningsUseCase,
    this.getStationQueueUseCase,
    this.getTripHistoryUseCase,
    this.listenToQueueNotificationsUseCase,
  ) : super(DriverHomeInitial());

  // ================= CURRENT POSITION =================

 Future<void> getCurrentPosition() async {
  emit(GetCurrentPositionLoading());

  if (AppConfig.useMockData) {
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      GetCurrentPositionSuccess(
        DriverHomeMockData.currentPosition,
      ),
    );
    return;
  }

  final result = await getCurrentPositionUseCase();

  result.fold(
    (failure) => emit(GetCurrentPositionError(failure.message)),
    (data) => emit(GetCurrentPositionSuccess(data)),
  );
}


  // ================= DAILY EARNINGS =================

 Future<void> getEstimatedDailyEarnings() async {
  emit(GetDailyEarningsLoading());

  if (AppConfig.useMockData) {
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      GetDailyEarningsSuccess(
        DriverHomeMockData.earnings,
      ),
    );
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
  required String stationId,
  required String routeId,
}) async {
  emit(GetStationQueueLoading());

  if (AppConfig.useMockData) {
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      GetStationQueueSuccess(
        DriverHomeMockData.stationQueue,
      ),
    );
    return;
  }

  final result = await getStationQueueUseCase(
    stationId: stationId,
    routeId: routeId,
  );

  result.fold(
    (failure) => emit(GetStationQueueError(failure.message)),
    (data) => emit(GetStationQueueSuccess(data)),
  );
}


  // ================= TRIP HISTORY =================

 Future<void> getTripHistory() async {
  emit(GetTripHistoryLoading());

  if (AppConfig.useMockData) {
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      GetTripHistorySuccess(
        DriverHomeMockData.tripHistory,
      ),
    );
    return;
  }

  final result = await getTripHistoryUseCase();

  result.fold(
    (failure) => emit(GetTripHistoryError(failure.message)),
    (data) => emit(GetTripHistorySuccess(data)),
  );
}


  // ================= QUEUE NOTIFICATIONS =================

  Future<void> listenToQueueNotifications() async {
    emit(ListenQueueNotificationsLoading());

    final result = await listenToQueueNotificationsUseCase();

    result.fold(
      (failure) => emit(ListenQueueNotificationsError(failure.message)),
      (event) => emit(ListenQueueNotificationsSuccess(event)),
    );
  }
}
