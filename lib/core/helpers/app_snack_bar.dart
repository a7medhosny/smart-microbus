import 'package:flutter/material.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';

void showGlobalSnackBar(String message) {
  final context = navigatorKey.currentContext;

  if (context == null) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}
