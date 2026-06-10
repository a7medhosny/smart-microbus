import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

String getArrivalTime( {BuildContext? context, int? minutes, bool shortFormat = false}) {
  AppLocalizations l10n = AppLocalizations.of(context!)!;
  if (minutes == null) return '';

  if (minutes <= 60) {
    if (shortFormat) {
      return l10n.minutesShort(minutes);
    }
    return l10n.afterMinutes(minutes);
  }

  final hours = minutes / 60;
  final formattedHours =
      hours % 1 == 0 ? hours.toInt().toString() : hours.toStringAsFixed(1);
if (shortFormat) {
    return l10n.hoursShort(formattedHours);
  }
  return l10n.afterhours(formattedHours);
}