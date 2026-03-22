import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class CurrentLocationCard extends StatelessWidget {
  const CurrentLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔵 Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: theme.colorScheme.primary,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          /// 📍 Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Title
                Text(
                  l10n.welcomeToMinya,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                /// 🔹 Description
                Text(
                  l10n.currentLocationHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),

          /// ➡️ Arrow (optional UX hint)
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: theme.colorScheme.onSurface.withAlpha(120),
          ),
        ],
      ),
    );
  }
}
