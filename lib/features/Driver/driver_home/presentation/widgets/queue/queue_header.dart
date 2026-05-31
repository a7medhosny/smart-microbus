/// presentation/widgets/queue/queue_header.dart
library;

import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';
import 'queue_live_indicator.dart';

class QueueHeader extends StatelessWidget {
  final int queueLength;

  const QueueHeader({
    super.key,
    required this.queueLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(.14),
            theme.colorScheme.surfaceContainerHighest.withOpacity(.85),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(.05),
        ),
      ),
      child: Row(
        children: [
          const QueueLiveIndicator(),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.liveQueue,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: .8,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  l10n.realtimeStationUpdates,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: theme.colorScheme.primary.withOpacity(.12),
            ),
            child: Text(
              l10n.driversCount(queueLength),
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}