import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip.dart';
import '../../../../../../l10n/app_localizations.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${trip.amount} ${l10n.egp}",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _statusBadge(context, l10n.completed),
              ],
            ),

            const SizedBox(height: 14),

            _tripRoute(context, trip.routeFrom, trip.routeTo),

            const SizedBox(height: 14),

            Divider(color: theme.dividerColor),

            const SizedBox(height: 10),

            /// معلومات الرحلة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tripInfo(
                  context,
                  Icons.route,
                  "${trip.distance.toStringAsFixed(1)}  km",
                ),
                _tripInfo(
                  context,
                  Icons.people,
                  trip.passengerCount.toString(),
                ),
                _tripInfo(
                  context,
                  Icons.calendar_today,
                  DateFormat('dd MMM yyyy').format(trip.startedAt),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================
/// Status Badge
/// ===============================
Widget _statusBadge(BuildContext context, String text) {
  final theme = Theme.of(context);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        color: Colors.green,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// ===============================
/// Route UI
/// ===============================
Widget _tripRoute(BuildContext context, String from, String to) {
  final theme = Theme.of(context);

  return Row(
    children: [
      const Icon(Icons.radio_button_checked, size: 16),
      const SizedBox(width: 6),

      Expanded(child: Text(from)),

      Icon(Icons.arrow_forward, size: 18, color: theme.colorScheme.primary),

      const SizedBox(width: 6),

      Expanded(child: Text(to, textAlign: TextAlign.end)),

      const SizedBox(width: 6),
      const Icon(Icons.circle, size: 14),
    ],
  );
}

/// ===============================
/// Trip Info
/// ===============================
Widget _tripInfo(BuildContext context, IconData icon, String text) {
  final theme = Theme.of(context);

  return Row(
    children: [
      Icon(icon, size: 18),
      const SizedBox(width: 6),
      Text(text, style: theme.textTheme.bodySmall),
    ],
  );
}
