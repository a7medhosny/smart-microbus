import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

import '../../../../maps/domain/entities/driver_location_entity.dart';

import 'tracking_info_item.dart';

class TrackingInfoCard extends StatelessWidget {
  final DriverLocationEntity location;

  const TrackingInfoCard({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            TrackingInfoItem(
              title: loc.distance,
              value:
                  '${location.distance.toStringAsFixed(1)} km',
            ),

            TrackingInfoItem(
              title: loc.duration,
              value:
                  '${location.duration.toStringAsFixed(0)} min',
            ),

            TrackingInfoItem(
              title: loc.updated,
              value: _formatTime(
                location.lastUpdated,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? date) {
    if (date == null) return '--';

    final hour =
        date.hour.toString().padLeft(2, '0');

    final minute =
        date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}