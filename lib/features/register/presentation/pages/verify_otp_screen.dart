import 'package:flutter/material.dart';

import '../controllers/otp_controller.dart';
import '../widgets/otp_widgets/otp_header.dart';
import '../widgets/otp_widgets/otp_pinput_field.dart';
import '../widgets/otp_widgets/otp_verify_button.dart';
import '../widgets/otp_widgets/resend_code_text.dart';

class VerifyOtpScreen extends StatefulWidget {
   const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.from,
  });

  final String phoneNumber;
  final String from;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final controller = OtpController();
  @override
  void initState() {
    super.initState();
    controller.startResendTimer(seconds: 60); // start timer when open the screen
  }

  @override
  void dispose() {
    controller.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              OtpHeader(phoneNumber: widget.phoneNumber),

              const SizedBox(height: 40),

              OtpPinputField(
                controller: controller.pinController,
                onCompleted: (value) {
                  controller.onChanged(value);
                },
              ),

              const SizedBox(height: 40),

              OtpVerifyButton(
                controller: controller,
                phoneNumber: widget.phoneNumber,
                from: widget.from,
              ),

              const SizedBox(height: 16),

              ResendCodeText(
                phoneNumber: widget.phoneNumber,
                controller: controller,
                from: widget.from,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
