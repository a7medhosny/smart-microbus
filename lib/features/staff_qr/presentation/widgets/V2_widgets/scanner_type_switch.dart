import 'package:flutter/material.dart';

import '../../screens/staff_qr_screenV2.dart';
import 'scanner_type_button.dart';

class ScannerTypeSwitch extends StatelessWidget {
  final ScanActionType selectedType;
  

  final VoidCallback onEntryTap;
  final VoidCallback onExitTap;

  final String entryTitle;
  final String entrySubtitle;

  final String exitTitle;
  final String exitSubtitle;

  const ScannerTypeSwitch({
    super.key,
    required this.selectedType,
    required this.onEntryTap,
    required this.onExitTap,
    required this.entryTitle,
    required this.entrySubtitle,
    required this.exitTitle,
    required this.exitSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: ScannerTypeButton(
              active: selectedType == ScanActionType.entry,
              color: theme.colorScheme.primary,
              icon: Icons.login_rounded,
              title: entryTitle,
              subtitle: entrySubtitle,
              onTap: onEntryTap,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ScannerTypeButton(
              active: selectedType == ScanActionType.exit,
              color: theme.colorScheme.error,
              icon: Icons.logout_rounded,
              title: exitTitle,
              subtitle: exitSubtitle,
              onTap: onExitTap,
            ),
          ),
        ],
      ),
    );
  }
}