import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/auth/session_manager.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routing/routes.dart';

class GuestBanner extends StatelessWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    if (!SessionManager.isGuest) {
      return const SizedBox();
    }

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(10),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(.08),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            tr.join_us,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(tr.guest_banner_desc, style: theme.textTheme.bodyMedium),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.login);
                  },

                  child: Text(tr.login),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.pushNamed(Routes.register);
                  },

                  child: Text(tr.register),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
