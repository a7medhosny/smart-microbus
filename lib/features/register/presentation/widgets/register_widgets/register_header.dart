import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

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
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
              ],
            ),
          ),
          child: const Center(
            child: CircleAvatar(
              radius: 28,
              child: Icon(Icons.directions_bus),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          loc.createNewAccount,
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(height: 8),

        Text(
          loc.registerToSmartMicrobus,
          style: Theme.of(context)
              .textTheme
              .bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
