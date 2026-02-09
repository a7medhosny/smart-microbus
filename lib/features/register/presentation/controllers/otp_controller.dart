import 'package:flutter/material.dart';

class OtpController extends ChangeNotifier {
  final TextEditingController
      pinController =
      TextEditingController();

  bool isCompleted = false;

  String get otp =>
      pinController.text;

  void onChanged(String value) {
    isCompleted = value.length == 6;
    notifyListeners();
  }

  void disposeAll() {
    pinController.dispose();
  }
}
