import 'package:flutter/material.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
              ],
            ),
          ),
          child: const Center(
            child: CircleAvatar(radius: 28, child: Icon(Icons.directions_bus)),
          ),
        ),

        verticalSpace(30),

        Text(loc.welcomeBack, style: Theme.of(context).textTheme.titleLarge),

        verticalSpace(10),

        Text(
          loc.loginToContinue,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
