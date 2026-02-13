import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routing/routes.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(loc.alreadyHaveAccount),
        TextButton(
          onPressed: () {
            context.pushNamed(Routes.login);
          },
          child: Text(loc.loginNow),
        ),
      ],
    );
  }
}
