import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        Icon(
          Icons.sms_rounded,
          size: 70,
          color: Theme.of(context).colorScheme.primary,
        ),

        const SizedBox(height: 16),

        Text(loc.verifyOtpTitle, style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 8),

        Text(
          "${loc.otpSentTo} $phoneNumber",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
