import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Text(loc.alreadyHaveAccount),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(loc.loginNow),
        ),
      ],
    );
  }
}
