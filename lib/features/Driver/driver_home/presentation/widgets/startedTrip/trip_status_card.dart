/// presentation/widgets/trip/trip_status_card.dart

import 'package:flutter/material.dart';

import '../../../../../../core/helpers/spacing.dart';


import '../../../../../../l10n/app_localizations.dart';
import 'trip_live_badge.dart';

class TripStatusCard extends StatelessWidget {
  final String startedSince;

  const TripStatusCard({
    super.key,
    required this.startedSince,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(.12),
            theme.colorScheme.surfaceContainerHighest.withOpacity(.72),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primaryContainer,
                ],
              ),
            ),
            child: const Icon(
              Icons.directions_bus_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          horizontalSpace(14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tripStarted,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                verticalSpace(4),

                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: theme.colorScheme.primary,
                    ),

                    horizontalSpace(5),

                    Expanded(
                      child: Text(
                        l10n.tripStartedSince(startedSince),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          horizontalSpace(8),

          const TripLiveBadge(),
        ],
      ),
    );
  }
}