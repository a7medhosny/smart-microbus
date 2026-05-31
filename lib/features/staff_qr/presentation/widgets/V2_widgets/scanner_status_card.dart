import 'package:flutter/material.dart';
import '../../screens/staff_qr_screenV2.dart';


class ScannerStatusCard extends StatelessWidget {
  final ScanResultState resultState;
  final String loadingText;
  final String readyText;

  const ScannerStatusCard({
    super.key,
    required this.resultState,
    required this.loadingText,
    required this.readyText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isLoading =
        resultState == ScanResultState.loading;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLoading
                  ? Colors.orange
                  : Colors.green,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              isLoading ? loadingText : readyText,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}