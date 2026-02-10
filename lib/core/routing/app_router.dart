import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/DI/dependency_injection.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/login_Screen.dart';
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

      // ================= REGISTER =================
      case Routes.register:
        return _materialRoute(const Placeholder());

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
