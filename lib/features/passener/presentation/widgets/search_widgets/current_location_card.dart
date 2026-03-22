import 'package:flutter/material.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/routing/routes.dart';

class CurrentLocationCard extends StatelessWidget {
  const CurrentLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withAlpha(180),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 👤 Avatar
          InkWell(
            onTap: () {
              context.pushNamed(Routes.profile);
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white.withOpacity(.2),
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),

          const SizedBox(width: 12),

          const SizedBox(width: 12),

          /// 📝 Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Title
                Row(
                  children: [
                    /// 📍 Location Icon
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.welcomeToMinya,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                /// Description
                Text(
                  l10n.currentLocationHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
