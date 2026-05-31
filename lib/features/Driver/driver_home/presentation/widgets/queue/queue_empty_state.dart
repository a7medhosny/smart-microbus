/// presentation/widgets/queue/queue_empty_state.dart
library;

import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class QueueEmptyState extends StatelessWidget {
  const QueueEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withOpacity(.7),
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.hourglass_empty_rounded,
              size: 50,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: 16),

            Text(
              l10n.noDriversInQueue,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.waitingDriversQueue,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}