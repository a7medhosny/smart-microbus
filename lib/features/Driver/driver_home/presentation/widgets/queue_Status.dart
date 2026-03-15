import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class QueueStatusSection extends StatelessWidget {
  const QueueStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        final cubit = context.watch<DriverHomeCubit>();
        final pos = cubit.myPosition;

        int vehiclesAhead = 0;
        int waitingMinutes = 0;

        if (pos != null) {
          vehiclesAhead = pos.position ?? 0 - 1;
          // waitingMinutes = DateTime.now().difference(pos.joinedAt).inMinutes;
        }

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  l10n.queueTitle,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),

            verticalSpace(12),
            Row(
              children: [
                Expanded(
                  child: _QueueInfoCard(
                    icon: Icons.access_time_filled,
                    iconColor: const Color(0xff6C63FF),
                    value: "$waitingMinutes ",
                    label: l10n.waitingTime,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: _QueueInfoCard(
                    icon: Icons.directions_bus,
                    iconColor: const Color(0xffF97316),
                    value: "$vehiclesAhead",
                    label: l10n.vehiclesAhead,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _QueueInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _QueueInfoCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(70),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),

          verticalSpace(12),

          Text(value, style: theme.textTheme.titleLarge),

          verticalSpace(4),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
