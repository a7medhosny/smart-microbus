import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';


class StaffQrAppBar extends StatelessWidget {
  final VoidCallback onThemeTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onLogoutTap;

  const StaffQrAppBar({
    super.key,
    required this.onThemeTap,
    required this.onLanguageTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.qr_code_scanner_rounded,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr.busGateScanner,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                tr.readyForScanning,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onSelected: (value) {
            switch (value) {
              case "theme":
                onThemeTap();
                break;

              case "language":
                onLanguageTap();
                break;

              case "logout":
                onLogoutTap();
                break;
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(value: "theme", child: Text(tr.changeTheme)),

              PopupMenuItem(value: "language", child: Text(tr.changeLanguage)),

              const PopupMenuDivider(),

              PopupMenuItem(value: "logout", child: Text(tr.logout)),
            ];
          },
        ),
      ],
    );
  }
}