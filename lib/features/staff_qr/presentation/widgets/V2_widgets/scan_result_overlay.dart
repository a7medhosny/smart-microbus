import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../screens/staff_qr_screenV2.dart';



class ScanResultOverlay extends StatelessWidget {
  final ScanResultState resultState;
  final String message;
  final String loadingText;

  const ScanResultOverlay({
    super.key,
    required this.resultState,
    required this.message,
    required this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;


    if (resultState == ScanResultState.idle) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.black.withOpacity(.45),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (resultState ==
                    ScanResultState.loading)
                  Lottie.asset(
                    'assets/animations/loading.json',
                    width: 150,
                  ),

                if (resultState ==
                    ScanResultState.success)
                  Lottie.asset(
                    'assets/animations/success.json',
                    width: 180,
                    repeat: false,
                  ),

                if (resultState ==
                    ScanResultState.error)
                  Lottie.asset(
                    'assets/animations/error.json',
                    width: 180,
                    repeat: false,
                  ),

                const SizedBox(height: 10),

                Text(
                  resultState ==
                          ScanResultState.loading
                      ? loadingText
                      : resultState ==
                              ScanResultState.success
                          ? tr.success
                          : tr.failed,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}