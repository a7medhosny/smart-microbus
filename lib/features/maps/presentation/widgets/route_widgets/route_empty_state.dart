import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';


class RouteEmptyState extends StatelessWidget {
  const RouteEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(
        child: Text(
          loc.chooseStations,
          style: textTheme.titleMedium,
        ),
      ),
    );
  }
}