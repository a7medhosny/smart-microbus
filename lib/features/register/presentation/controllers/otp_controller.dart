import 'dart:async';
import 'package:flutter/material.dart';

class OtpController extends ChangeNotifier {
  // ================= PIN =================

  final TextEditingController pinController =
      TextEditingController();

  bool isCompleted = false;

  String get otp => pinController.text;

  void onChanged(String value) {
    isCompleted = value.length == 6;
    notifyListeners();
  }

  // ================= RESEND TIMER =================

  static const int _initialSeconds = 60;

  int _secondsRemaining = _initialSeconds;
  int get secondsRemaining => _secondsRemaining;

  bool get canResend => _secondsRemaining == 0;

  Timer? _timer;

  // يبدأ العداد
  void startResendTimer() {
    _secondsRemaining = _initialSeconds;
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          notifyListeners();
        } else {
          timer.cancel();
          notifyListeners();
        }
      },
    );
  }

  // إعادة تشغيل بعد resend
  void resetResendTimer() {
    startResendTimer();
  }

  // فورمات 00:59
  String get formattedTime {
    final minutes =
        (_secondsRemaining ~/ 60)
            .toString()
            .padLeft(2, '0');

    final seconds =
        (_secondsRemaining % 60)
            .toString()
            .padLeft(2, '0');

    return "$minutes:$seconds";
  }

  // ================= DISPOSE =================

  void disposeAll() {
    _timer?.cancel();
    pinController.dispose();
  }
}
