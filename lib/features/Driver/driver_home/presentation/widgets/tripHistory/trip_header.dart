import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class TripsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int total;
  final VoidCallback? onFilterPressed;

  const TripsAppBar({super.key, required this.total, this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      title: Text(l10n.tripsHistory),

      actions: [
        /// FILTER BUTTON
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: onFilterPressed,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "$total ${l10n.egp}",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
