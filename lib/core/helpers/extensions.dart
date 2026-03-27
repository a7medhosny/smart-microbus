import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  /// 🔵 Navigator الحالي (غالبًا بتاع التاب)
  NavigatorState get nav => Navigator.of(this);

  /// 🟢 Navigator الرئيسي (Root)
  NavigatorState get rootNav =>
      Navigator.of(this, rootNavigator: true);

  /// ================= PUSH =================

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return nav.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushNamedRoot<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return rootNav.pushNamed<T>(routeName, arguments: arguments);
  }

  /// ================= PUSH REPLACE =================

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return nav.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementNamedRoot<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return rootNav.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  /// ================= REMOVE UNTIL =================

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return nav.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntilRoot<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return rootNav.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// ================= POP =================

  void pop<T extends Object?>([T? result]) {
    nav.pop(result);
  }

  void popRoot<T extends Object?>([T? result]) {
    rootNav.pop(result);
  }
}