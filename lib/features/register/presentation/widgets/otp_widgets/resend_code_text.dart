import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class ResendCodeText
    extends StatelessWidget {
  const ResendCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return TextButton(
      onPressed: () {
        // TODO: resend otp
      },
      child: Text(
        loc.resendCode,
        style: TextStyle(
          color: Theme.of(context)
              .colorScheme
              .primary,
        ),
      ),
    );
  }
}
