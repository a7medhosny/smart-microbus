import 'package:flutter/material.dart';
import 'package:smart_microbus/features/register/presentation/pages/register_screen.dart';
import 'package:smart_microbus/features/register/presentation/pages/verify_otp_screen.dart';
import 'package:smart_microbus/main.dart';

import 'routes.dart';

// ================= IMPORT SCREENS =================
// Auth
// import 'package:smart_microbus/features/auth/login_screen.dart';

// Layout
// import 'package:smart_microbus/features/layout/layout_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ================= INITIAL =================
      case Routes.initial:
        return _materialRoute(const HomeScreen());

      // ================= LOGIN =================
      case Routes.login:
        return _materialRoute(
          const Placeholder(), // LoginScreen()
        );

      // ================= REGISTER =================
      case Routes.register:
        return _materialRoute(const RegisterScreen());

      // ================= OTP VERIFICATION =================
      case Routes.otpVerification:
        final String phoneNumber = settings.arguments as String;
        return _materialRoute( VerifyOtpScreen(phoneNumber: phoneNumber));

      // ================= DEFAULT =================
      default:
        return null;
    }
  }

  // ================= HELPER =================
  MaterialPageRoute _materialRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
