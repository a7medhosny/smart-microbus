import 'package:flutter/material.dart';
import 'package:smart_microbus/features/register/presentation/pages/register_screen.dart';
import 'package:smart_microbus/features/register/presentation/pages/verify_otp_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/DI/dependency_injection.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/forgetp_password_screen.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/login_Screen.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/reset_password_screen.dart';
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
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      // ================= forget password =================
      case Routes.forgotPassword:
        return _materialRoute(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: ForgetpPasswordScreen(),
          ),
        );
      // ================= reset password =================
      case Routes.resetPassword:
        final phone = settings.arguments as String;
        return _materialRoute(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: ResetPasswordScreen(phone: phone),
          ),
          settings: settings,
        );
      // ================= REGISTER =================
      case Routes.register:
        return _materialRoute(const RegisterScreen());

      // ================= OTP VERIFICATION =================
      case Routes.otpVerification:
        {
          final args = settings.arguments as Map<String, dynamic>;

          final String phoneNumber = args["phone"];
          final String from = args["from"];
          return _materialRoute(
            VerifyOtpScreen(phoneNumber: phoneNumber, from: from),
          );
        }
      // ================= DEFAULT =================
      default:
        return null;
    }
  }

  // ================= HELPER =================
  MaterialPageRoute _materialRoute(Widget screen, {RouteSettings? settings}) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }
}
