import 'dart:async';

import 'package:signalr_netcore/signalr_client.dart';

import 'package:smart_microbus/core/auth/token_manager.dart';

import '../../../maps/data/models/driver_location_model.dart';
import '../../../maps/domain/entities/driver_location_entity.dart';
import 'passenger_location_datasource.dart';

class PassengerLocationDataSourceImpl implements PassengerLocationDataSource {
  HubConnection? _connection;

  final _locationController =
      StreamController<DriverLocationEntity>.broadcast();

  @override
  Stream<DriverLocationEntity> get locationStream => _locationController.stream;

  String? _driverId;

  PassengerLocationDataSourceImpl() {
    TokenManager.onTokenRefreshed.listen((_) {
      refreshConnection();
    });
  }

  @override
  Future<void> connect(String driverId) async {
    if (_connection != null) {
      await disconnect();
    }

    _driverId = driverId;

    _connection = HubConnectionBuilder()
        .withUrl(
          "https://smart-microbus.runasp.net/hubs/location-tracking",
          options: HttpConnectionOptions(
            accessTokenFactory: () async {
              return TokenManager.token ?? '';
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    _connection!.onreconnected(({String? connectionId}) async {
      await _joinDriver();
    });

    _registerEvents();

    await _connection!.start();

    await _joinDriver();
  }

  Future<void> _joinDriver() async {
    if (_driverId == null || _connection == null) return;
print("Joining driver: $_driverId");
    await _connection!.invoke("JoinDriver", args: [_driverId!]);
  }

  void _registerEvents() {
    _connection!.off("ReceiveLocation");

    _connection!.on("ReceiveLocation", (args) {
      if (args != null && args.isNotEmpty) {
        final model = DriverLocationModel.fromJson(
          args[0] as Map<String, dynamic>,
        );

        _locationController.add(model.toEntity());
      }
    });
  }

  @override
  Future<void> leaveDriver() async {
    if (_driverId == null || _connection == null) return;
print("Leaving driver: $_driverId");
    await _connection!.invoke("LeaveDriver", args: [_driverId!]);
  }

  @override
  Future<void> refreshConnection() async {
    if (_connection == null) return;

    await _connection!.stop();

    await _connection!.start();

    await _joinDriver();
  }

  @override
  Future<void> disconnect() async {
    try {
      await leaveDriver();

      await _connection?.stop();
    } catch (_) {}

    _connection = null;

    _driverId = null;
  }
}
