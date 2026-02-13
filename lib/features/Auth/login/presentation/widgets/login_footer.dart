import 'package:flutter/material.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              context.pushNamed(Routes.forgotPassword);
            },
            child: Text(
              loc.forgotPassword,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        verticalSpace(30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.dontHaveAccount,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(Routes.register);
              },
              child: Text(
                loc.registerNow,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
