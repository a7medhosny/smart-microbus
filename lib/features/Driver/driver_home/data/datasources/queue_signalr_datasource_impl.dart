import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';

import '../../domain/entities/queue_event.dart';
import '../models/queue_item_model.dart';
import 'queue_signalr_datasource.dart';

class QueueSignalRDataSourceImpl implements QueueSignalRDataSource {
  HubConnection? _connection;

  final _eventController = StreamController<QueueEvent>.broadcast();

  @override
  Stream<QueueEvent> get queueEvents => _eventController.stream;

  @override
  Future<void> connect(String queueId) async {
    print("🚀 Starting SignalR connection...");
    print("📌 QueueId: $queueId");

    try {
      print("🔑 Reading token from secure storage...");

      final token = TokenManager.token;

      if (token == null) {
        print("❌ Token is NULL");
      } else {
        print("✅ Token retrieved successfully");
      }

      print("🏗 Building SignalR connection...");

      _connection = HubConnectionBuilder()
          .withUrl(
            "https://smart-microbus.runasp.net/hubs/driver-queue",
            options: HttpConnectionOptions(
              accessTokenFactory: () async {
                print("📡 Sending access token with request");
                return token ?? '';
              },
            ),
          )
          .withAutomaticReconnect()
          .build();

      print("✅ HubConnection created");

      _connection!.onclose(({Exception? error}) {
        print("❌ Connection closed: $error");
      });

      _connection!.onreconnecting(({Exception? error}) {
        print("🔄 Reconnecting: $error");
      });

      _connection!.onreconnected(({String? connectionId}) {
        print("✅ Reconnected: $connectionId");
      });

      /// Driver Added Event
      _connection!.on("DriverAdded", (args) {
        print("📥 DriverAdded event received");
        print("📦 Raw args: $args");

        try {
          if (args != null && args.isNotEmpty) {
            print("🔍 Parsing driver data...");

            final queueItem = QueueItemModel.fromJson(
              args[0] as Map<String, dynamic>,
            );

            print("✅ Driver parsed successfully");
            print("👤 DriverId: ${queueItem.driverId}");
            print("📍 Position: ${queueItem.position}");

            _eventController.add(DriverAddedEvent(queueItem.toEntity()));

            print("📤 DriverAddedEvent sent to stream");
          } else {
            print("⚠ DriverAdded args are empty");
          }
        } catch (e) {
          print("❌ DriverAdded parse error: $e");
        }
      });

      /// Driver Removed Event
      _connection!.on("DriverRemoved", (args) {
        print("📥 DriverRemoved event received");
        print("📦 Raw args: $args");

        try {
          if (args != null && args.isNotEmpty) {
            final driverId = args[0] as String;

            print("🚫 Driver removed with ID: $driverId");

            _eventController.add(DriverRemovedEvent(driverId));

            print("📤 DriverRemovedEvent sent to stream");
          } else {
            print("⚠ DriverRemoved args are empty");
          }
        } catch (e) {
          print("❌ DriverRemoved parse error: $e");
        }
      });

      print("🔌 Starting SignalR connection...");

      await _connection!.start();

      print("✅ SignalR Connected successfully");

      print("👥 Joining queue group...");

      await _connection!.invoke("JoinQueueGroup", args: [queueId]);

      print("✅ Joined queue group successfully");
      print("📡 Listening for queue events...");
    } catch (e) {
      print("❌ SignalR connection error: $e");
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    print("🛑 Disconnecting SignalR...");

    try {
      await _connection?.stop();

      print("✅ SignalR connection stopped");

      await _eventController.close();

      print("✅ Event stream closed");
    } catch (e) {
      print("❌ SignalR disconnect error: $e");
    }
  }
}
