import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';

import '../../domain/entities/queue_event.dart';
import '../models/queue_item_model.dart';
import 'queue_signalr_datasource.dart';

class QueueSignalRDataSourceImpl implements QueueSignalRDataSource {
  HubConnection? _connection;

  final _eventController = StreamController<QueueEvent>.broadcast();

  String? _queueId;
  bool _isConnecting = false;

  /// 🔥 NEW: نسمع لما التوكن يتغير
  QueueSignalRDataSourceImpl() {
    TokenManager.onTokenRefreshed.listen((_) {
      print("🔄 Token refreshed → restarting SignalR");
      refreshConnection();
    });
  }

  @override
  Stream<QueueEvent> get queueEvents => _eventController.stream;

  @override
  Future<void> connect(String queueId) async {
    if (_connection != null &&
        _connection!.state == HubConnectionState.Connected) {
      print("⚠️ Already connected to SignalR");
      return;
    }

    if (_isConnecting) return;

    _isConnecting = true;
    _queueId = queueId;

    try {
      _connection = HubConnectionBuilder()
          .withUrl(
            "https://smart-microbus.runasp.net/hubs/driver-queue",
            options: HttpConnectionOptions(
              accessTokenFactory: () async {
                return TokenManager.token ?? '';
              },
            ),
          )
          .withAutomaticReconnect()
          .build();

      _connection!.onreconnected(({String? connectionId}) async {
        await _rejoinGroup();
      });

      _registerEvents();

      await _connection!.start();

      await _joinGroup();
    } catch (e) {
      print("❌ SignalR connection error: $e");
      rethrow;
    } finally {
      _isConnecting = false;
    }
  }

  /// 🔥 NEW: restart بعد refresh token
  Future<void> refreshConnection() async {
    if (_connection == null || _queueId == null) return;

    try {
      print("🔄 Restarting SignalR...");

      await _connection!.stop();

      await _connection!.start();

      await _rejoinGroup();

      print("✅ SignalR restarted with new token");
    } catch (e) {
      print("❌ Restart failed: $e");
    }
  }

  Future<void> _joinGroup() async {
    if (_queueId == null) return;

    try {
      await _connection!.invoke("JoinQueueGroup", args: [_queueId!]);
    } catch (e) {
      print("❌ Join group failed: $e");
    }
  }

  Future<void> _rejoinGroup() async {
    if (_queueId == null) return;

    for (int i = 0; i < 3; i++) {
      try {
        await _connection!.invoke("JoinQueueGroup", args: [_queueId!]);
        return;
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  void _registerEvents() {
    _connection!.on("DriverAdded", (args) {
      if (args != null && args.isNotEmpty) {
        final queueItem = QueueItemModel.fromJson(
          args[0] as Map<String, dynamic>,
        );
        print(
          "🚗 DriverAdded event received: Name: ${queueItem.driverName}, Queue ID: ${queueItem.queueId}, Plate Number: ${queueItem.plateNumber}",
        );
        _eventController.add(DriverAddedEvent(queueItem.toEntity()));
      }
    });

    _connection!.on("DriverRemoved", (args) {
      if (args != null && args.isNotEmpty) {
        final driverId = args[0] as String;

        print("🚗 DriverRemoved event received: Driver ID: $driverId");
        _eventController.add(DriverRemovedEvent(driverId));
      }
    });
  }

  @override
  Future<void> disconnect() async {
    await _connection?.stop();
    _connection = null;
    _queueId = null;
  }
}
