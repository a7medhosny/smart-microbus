import 'package:flutter/material.dart';

import 'package:smart_microbus/core/auth/session_manager.dart';

import 'package:smart_microbus/core/services/noification_servises.dart';

import 'package:smart_microbus/my_app.dart';

import 'core/auth/token_manager.dart';
import 'core/di/dependency_injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 Initialize Dependency Injection
  await setupDependencyInjection();
  await NotificationService.init();
  await NotificationService.requestPermission();
  print("🟢Token: ${TokenManager.token}");
  print("🟢User ID: ${TokenManager.userId}");
  // final bool isLoggedIn = await initializeAuth();
  final sessionState = await SessionManager.initializeSession();
  runApp(MyApp(sessionState: sessionState));
}
