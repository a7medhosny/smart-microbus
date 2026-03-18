import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPinputField extends StatelessWidget {
  const OtpPinputField({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  final TextEditingController controller;
  final Function(String) onCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: theme.textTheme.titleLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outline),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.colorScheme.primary, width: 2),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.colorScheme.error),
    );

    return Pinput(
      controller: controller,
      length: 6,
      autofocus: true,

      // ✅ يخليه يعدل أي رقم بسهولة
      keyboardType: TextInputType.number,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      errorPinTheme: errorPinTheme,

      validator: (value) {
        if (value == null || value.length < 6) {
          return "Enter full code";
        }
        return null;
      },

      // ✅ لما يكتب كله
      onChanged: onCompleted,
    );
  }
}
