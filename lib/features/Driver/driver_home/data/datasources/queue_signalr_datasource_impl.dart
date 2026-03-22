import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';

import '../../domain/entities/queue_event.dart';
import '../models/queue_item_model.dart';
import 'queue_signalr_datasource.dart';

class QueueSignalRDataSourceImpl implements QueueSignalRDataSource {
  HubConnection? _connection;

  final _eventController = StreamController<QueueEvent>.broadcast();

  /// تحسين 1: حفظ queueId علشان نستخدمه بعد reconnect
  String? _queueId;

  /// تحسين 2: منع إنشاء أكتر من connection
  bool _isConnecting = false;

  @override
  Stream<QueueEvent> get queueEvents => _eventController.stream;

  @override
  Future<void> connect(String queueId) async {
    /// لو فيه connection شغال بالفعل، نمنع التكرار
    if (_connection != null &&
        _connection!.state == HubConnectionState.Connected) {
      print("⚠️ Already connected to SignalR");
      return;
    }

    /// منع double call أثناء الاتصال
    if (_isConnecting) return;

    _isConnecting = true;
    _queueId = queueId;

    print("🚀 Starting SignalR connection...");
    print("📌 QueueId: $queueId");

    try {
      final token = TokenManager.token;

      if (token == null) {
        print("❌ Token is NULL");
      } else {
        print("✅ Token retrieved successfully");
      }

      _connection = HubConnectionBuilder()
          .withUrl(
            "https://smart-microbus.runasp.net/hubs/driver-queue",
            options: HttpConnectionOptions(
              /// تحسين 3: ضمان إرسال token في كل reconnect
              accessTokenFactory: () async {
                print("📡 Sending access token with request");
                return TokenManager.token ?? '';
              },
            ),
          )
          /// تحسين 4: تفعيل auto reconnect
          .withAutomaticReconnect()
          .build();

      /// ================= Lifecycle Handling =================

      _connection!.onclose(({Exception? error}) {
        print("❌ Connection closed: $error");
      });

      _connection!.onreconnecting(({Exception? error}) {
        print("🔄 Reconnecting: $error");
      });

      _connection!.onreconnected(({String? connectionId}) async {
        print("✅ Reconnected: $connectionId");

        /// تحسين 5 (مهم جدًا):
        /// بعد reconnect لازم نرجع ننضم للجروب تاني
        await _rejoinGroup();
      });

      /// ================= Events =================

      /// تحسين 6: عمل register للأحداث بشكل آمن
      _registerEvents();

      print("🔌 Starting SignalR connection...");
      await _connection!.start();

      print("✅ SignalR Connected successfully");

      /// أول مرة join
      await _joinGroup();

      print("📡 Listening for queue events...");
    } catch (e) {
      print("❌ SignalR connection error: $e");
      rethrow;
    } finally {
      _isConnecting = false;
    }
  }

  /// ================= JOIN GROUP =================
  Future<void> _joinGroup() async {
    if (_queueId == null) return;

    try {
      print("👥 Joining queue group...");
      await _connection!.invoke("JoinQueueGroup", args: [_queueId!]);
      print("✅ Joined queue group successfully");
    } catch (e) {
      print("❌ Join group failed: $e");
    }
  }

  /// ================= REJOIN AFTER RECONNECT =================
  Future<void> _rejoinGroup() async {
    if (_queueId == null) return;

    /// تحسين 7: retry mechanism لو حصل فشل
    for (int i = 0; i < 3; i++) {
      try {
        print("🔁 Rejoining queue group... attempt ${i + 1}");

        await _connection!.invoke("JoinQueueGroup", args: [_queueId!]);

        print("✅ Rejoined queue group successfully");
        return;
      } catch (e) {
        print("❌ Rejoin failed: $e");

        /// انتظار قبل إعادة المحاولة
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  /// ================= EVENTS =================
  void _registerEvents() {
    /// تحسين 8: فصل تسجيل الأحداث لسهولة الإدارة

    _connection!.on("DriverAdded", (args) {
      print("📥 DriverAdded event received");

      try {
        if (args != null && args.isNotEmpty) {
          final queueItem = QueueItemModel.fromJson(
            args[0] as Map<String, dynamic>,
          );

          _eventController.add(
            DriverAddedEvent(queueItem.toEntity()),
          );

          print("📤 DriverAddedEvent emitted");
        }
      } catch (e) {
        print("❌ DriverAdded parse error: $e");
      }
    });

    _connection!.on("DriverRemoved", (args) {
      print("📥 DriverRemoved event received");

      try {
        if (args != null && args.isNotEmpty) {
          final driverId = args[0] as String;

          _eventController.add(
            DriverRemovedEvent(driverId),
          );

          print("📤 DriverRemovedEvent emitted");
        }
      } catch (e) {
        print("❌ DriverRemoved parse error: $e");
      }
    });
  }

  @override
  Future<void> disconnect() async {
    print("🛑 Disconnecting SignalR...");

    try {
      await _connection?.stop();

      /// تحسين 9: تصفير القيم بعد disconnect
      _connection = null;
      _queueId = null;

      print("✅ SignalR connection stopped");
    } catch (e) {
      print("❌ SignalR disconnect error: $e");
    }
  }
}