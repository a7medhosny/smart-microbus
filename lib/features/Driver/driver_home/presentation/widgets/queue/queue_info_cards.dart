/// presentation/widgets/queue/queue_info_cards.dart
library;

import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';
import 'queue_info_card.dart';

class QueueInfoCards extends StatelessWidget {
  final int vehiclesAhead;

  const QueueInfoCards({super.key, required this.vehiclesAhead});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: QueueInfoCard(
            icon: Icons.timer_rounded,
            iconColor: const Color(0xff8B5CF6),
            value: "0",
            label: l10n.waitingTime,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: QueueInfoCard(
            icon: Icons.directions_bus_rounded,
            iconColor: const Color(0xffF97316),
            value: "$vehiclesAhead",
            label: l10n.vehiclesAhead,
          ),
        ),
      ],
    );
  }
}
