import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routing/routes.dart';

Future<void> showGuestRequiredBottomSheet(BuildContext context) {
  final tr = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  return showModalBottomSheet(
    context: context,

    isScrollControlled: true,

    backgroundColor: theme.colorScheme.surface,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),

    builder: (_) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              /// Handle
              Container(
                width: 42,
                height: 5,

                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,

                  borderRadius: BorderRadius.circular(100),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: 72,
                height: 72,

                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.12),

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.lock_person_outlined,

                  size: 34,

                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                tr.login_required,

                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                tr.guest_access_message,

                textAlign: TextAlign.center,

                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,

                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.pushReplacementNamed(Routes.login);
                  },

                  child: Text(tr.login),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.pushReplacementNamed(Routes.register);
                  },

                  child: Text(tr.create_account),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
