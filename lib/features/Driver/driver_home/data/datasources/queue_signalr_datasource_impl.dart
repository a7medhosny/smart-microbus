import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';

import '../../domain/entities/dashboard_event.dart';
import '../../domain/entities/queue_event.dart';
import '../models/driver_current_status_model.dart';
import '../models/queue_item_model.dart';
import 'queue_signalr_datasource.dart';

class QueueSignalRDataSourceImpl implements QueueSignalRDataSource {
  HubConnection? _queueConnection;
  HubConnection? _dashboardConnection;

  final _queueController = StreamController<QueueEvent>.broadcast();
  final _dashboardController = StreamController<DashboardEvent>.broadcast();

  String? _queueId;

  QueueSignalRDataSourceImpl() {
    print("🟡 SignalR DataSource Initialized");

    TokenManager.onTokenRefreshed.listen((_) {
      print("🔄 Token refreshed → refreshing connections");
      refreshConnections();
    });
  }

  @override
  Stream<QueueEvent> get queueEvents => _queueController.stream;

  @override
  Stream<DashboardEvent> get dashboardEvents => _dashboardController.stream;

  // ===============================
  // 🔵 QUEUE CONNECTION
  // ===============================

  @override
  Future<void> connectQueue(String queueId) async {
    print("🚀 Connecting to Queue Hub...");
    print("📌 QueueId: $queueId");

    if (_queueConnection != null) {
      print("⚠️ Existing queue connection found → disconnecting first");
      await disconnectQueue();
    }

    _queueId = queueId;

    _queueConnection = HubConnectionBuilder()
        .withUrl(
          "https://smart-microbus.runasp.net/hubs/driver-queue",
          options: HttpConnectionOptions(
            accessTokenFactory: () async {
              final token = TokenManager.token ?? '';
              print("🔑 Using token: ${token.substring(0, 10)}...");
              return token;
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    print("🛠 Queue HubConnection created");

    _queueConnection!.onreconnected(({String? connectionId}) {
      _handleQueueReconnected();
    });
    _queueConnection!.onclose(({error}) {
      print("🔴 Queue connection closed: $error");
    });

    _queueConnection!.onreconnecting(({error}) {
      print("🟠 Queue reconnecting: $error");
    });

    _registerQueueEvents();

    print("⏳ Starting Queue connection...");
    await _queueConnection!.start();
    print("✅ Queue connected successfully");

    await _joinQueueGroup();
  }

  void _handleQueueReconnected() async {
    print("🔁 Rejoining Queue Group...");
    await _joinQueueGroup();
  }

  void _registerQueueEvents() {
    print("📡 Registering Queue events...");

    _queueConnection!.off("DriverAdded");
    _queueConnection!.off("DriverRemoved");

    _queueConnection!.on("DriverAdded", (args) {
      print("🟢 DriverAdded event raw: $args");

      if (args != null && args.isNotEmpty) {
        final item = QueueItemModel.fromJson(args[0] as Map<String, dynamic>);

        print(
          "🚗 DriverAdded → ${item.driverName} | Plate: ${item.plateNumber}",
        );

        _queueController.add(DriverAddedEvent(item.toEntity()));
      }
    });

    _queueConnection!.on("DriverRemoved", (args) {
      print("🔴 DriverRemoved event raw: $args");

      if (args != null && args.isNotEmpty) {
        final driverId = args[0] as String;

        print("❌ DriverRemoved → ID: $driverId");

        _queueController.add(DriverRemovedEvent(driverId));
      }
    });
  }

  Future<void> _joinQueueGroup() async {
    if (_queueId == null || _queueConnection == null) return;

    try {
      print("👥 Joining Queue Group: $_queueId");

      await _queueConnection!.invoke("JoinQueueGroup", args: [_queueId!]);

      print("✅ Joined Queue Group successfully");
    } catch (e) {
      print("❌ JoinQueueGroup failed: $e");
    }
  }

  // ===============================
  // 🟣 DASHBOARD CONNECTION
  // ===============================

  @override
  Future<void> connectDashboard() async {
    print("🚀 Connecting to Dashboard Hub...");

    if (_dashboardConnection != null) {
      print("⚠️ Existing dashboard connection → disconnecting first");
      await disconnectDashboard();
    }

    _dashboardConnection = HubConnectionBuilder()
        .withUrl(
          "https://smart-microbus.runasp.net/hubs/driver-dashboard",
          options: HttpConnectionOptions(
            accessTokenFactory: () async {
              final token = TokenManager.token ?? '';
              print("🔑 Dashboard token: ${token.substring(0, 10)}...");
              return token;
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    print("🛠 Dashboard HubConnection created");

    _dashboardConnection!.onreconnected(({String? connectionId}) {
      print("♻️ Dashboard Reconnected → connectionId: $connectionId");
      _handleDashboardReconnected();
    });

    _dashboardConnection!.onclose(({error}) {
      print("🔴 Dashboard connection closed: $error");
    });

    _dashboardConnection!.onreconnecting(({error}) {
      print("🟠 Dashboard reconnecting: $error");
    });

    _registerDashboardEvents();

    print("⏳ Starting Dashboard connection...");
    await _dashboardConnection!.start();
    print("✅ Dashboard connected successfully");

    print("👥 Joining Dashboard...");
    await _dashboardConnection!.invoke("JoinDashboard");
    print("✅ Joined Dashboard");
  }

  void _handleDashboardReconnected() async {
    try {
      print("🔁 Rejoining Dashboard...");
      await _dashboardConnection?.invoke("JoinDashboard");
    } catch (e) {
      print("❌ Rejoin dashboard failed: $e");
    }
  }

  void _registerDashboardEvents() {
    print("📡 Registering Dashboard events...");

    _dashboardConnection!.off("DashboardUpdated");

_dashboardConnection!.on("DashboardUpdated", (data) {
  print("📊 DashboardUpdated RAW: $data");

  if (data != null && data.isNotEmpty) {
    final json = data[0] as Map<String, dynamic>;

    final model = DriverCurrentStatusModel.fromJson(json);

    _dashboardController.add(
      DashboardUpdatedEvent(model.toEntity()),
    );
  }
});
  }

  // ===============================
  // 🔁 REFRESH TOKEN
  // ===============================

  Future<void> refreshConnections() async {
    try {
      print("🔄 Refreshing SignalR connections...");

      if (_queueConnection != null) {
        print("🔁 Restarting Queue connection...");
        await _queueConnection!.stop();
        await _queueConnection!.start();
        await _joinQueueGroup();
      }

      if (_dashboardConnection != null) {
        print("🔁 Restarting Dashboard connection...");
        await _dashboardConnection!.stop();
        await _dashboardConnection!.start();
        await _dashboardConnection!.invoke("JoinDashboard");
      }

      print("✅ Connections refreshed");
    } catch (e) {
      print("❌ Refresh connections failed: $e");
    }
  }

  // ===============================
  // 🔌 DISCONNECT
  // ===============================

  @override
  Future<void> disconnectQueue() async {
    try {
      print("🛑 Disconnecting Queue...");
      await _queueConnection?.stop();
      _queueConnection = null;
      _queueId = null;
      print("✅ Queue disconnected");
    } catch (e) {
      print("❌ Error stopping queue connection: $e");
    }
  }

  @override
  Future<void> disconnectDashboard() async {
    try {
      print("🛑 Disconnecting Dashboard...");
      await _dashboardConnection?.stop();
      _dashboardConnection = null;
      print("✅ Dashboard disconnected");
    } catch (e) {
      print("❌ Error stopping dashboard connection: $e");
    }
  }

  @override
  Future<void> disconnectAll() async {
    print("🛑 Disconnecting ALL SignalR...");
    await disconnectQueue();
    await disconnectDashboard();
  }
}
