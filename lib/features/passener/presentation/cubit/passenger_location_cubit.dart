import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../maps/domain/entities/driver_location_entity.dart';
import '../../../maps/domain/usecases/get_driver_location_use_case.dart';

import '../../domain/usecases/location_usecases/connect_to_driver_location_usecase.dart';
import '../../domain/usecases/location_usecases/disconnect_driver_location_usecase.dart';
import '../../domain/usecases/location_usecases/listen_to_driver_location_usecase.dart';

part 'passenger_location_state.dart';

class PassengerLocationCubit extends Cubit<PassengerLocationState> {
  final ConnectToDriverLocationUseCase connectUseCase;

  final DisconnectDriverLocationUseCase disconnectUseCase;

  final ListenToDriverLocationUseCase listenUseCase;

  final GetDriverLocationUseCase getLocationUseCase;

  StreamSubscription? _locationSubscription;

  PassengerLocationCubit(
    this.connectUseCase,
    this.disconnectUseCase,
    this.listenUseCase,
    this.getLocationUseCase,
  ) : super(const PassengerLocationState());

  Future<void> connect(String driverId) async {
    emit(state.copyWith(loading: true, error: null));

    // =========================
    // INITIAL LOCATION
    // =========================

    final initialResult = await getLocationUseCase(driverId);

    initialResult.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (location) {
        emit(state.copyWith(loading: false, location: location));
      },
    );

    // =========================
    // SIGNALR CONNECTION
    // =========================

    final connectResult = await connectUseCase(driverId);

    connectResult.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (_) async {
        await _locationSubscription?.cancel();

        _locationSubscription = listenUseCase().listen((location) {
          emit(state.copyWith(location: location));
        });
      },
    );
  }

  Future<void> disconnect() async {
    await _locationSubscription?.cancel();

    _locationSubscription = null;

    final result = await disconnectUseCase();

    result.fold((failure) {
      emit(state.copyWith(error: failure.message));
    }, (_) {});
  }

  @override
  Future<void> close() async {
    await disconnect();

    return super.close();
  }
}
