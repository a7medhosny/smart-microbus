import 'package:signalr_netcore/signalr_client.dart';

class RouteTrackingService {
  HubConnection? _connection;

  Future<void> connect({
    required String routeId,
    required Function(Map<String, dynamic>) onRouteUpdated,
  }) async {
    _connection = HubConnectionBuilder()
        .withUrl("https://smart-microbus.runasp.net/hubs/route-tracking")
        .withAutomaticReconnect()
        .build();

    _connection!.on("RouteUpdated", (arguments) {
      print("🔥 RouteUpdated Fired");
      print("Arguments => $arguments");

      if (arguments == null || arguments.isEmpty) {
        print("❌ Empty Arguments");
        return;
      }

      try {
        final data = Map<String, dynamic>.from(arguments.first as Map);

        print("📦 RouteUpdated Data => $data");

        onRouteUpdated(data);
      } catch (e) {
        print("❌ Parse Error => $e");
      }
    });

    print("⏳ Starting SignalR...");

    await _connection!.start();

    print("🟢 SignalR Connected");

    print("⏳ Joining Route => $routeId");

    await _connection!.invoke("JoinRoute", args: [routeId]);

    print("🟢 Joined Route => $routeId");
    print("🟢 Connection State => ${_connection!.state}");
  }

  Future<void> leaveRoute(String routeId) async {
    if (_connection == null) return;

    print("🚪 Leaving Route => $routeId");

    await _connection!.invoke("LeaveRoute", args: [routeId]);
  }

  Future<void> disconnect() async {
    print("❌ Disconnecting SignalR");

    await _connection?.stop();
  }
}
