import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class QueueListSection extends StatelessWidget {
  const QueueListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        final cubit = context.watch<DriverHomeCubit>();
        final queue = cubit.queue;
        final myPos = cubit.myPosition;

        if (queue == null || myPos == null) {
          print("Queue or My Position is null - Queue: ${queue == null}, My Position: ${myPos == null}");
          return const SizedBox();
        }

print("Queue length: ${queue.length}");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.nextInQueue, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),

            Container(
              height: 250.h,
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListView.builder(
                shrinkWrap: true,

                itemCount: queue.length,
                itemBuilder: (context, index) {
                  final item = queue[index];
                  final isMe = item.driverId == myPos.driverId;

                  return Column(
                    children: [
                      _QueueItem(
                        vehicle: item.driverId,
                        position: item.position,
                        status: item.status,
                        isMe: isMe,
                      ),
                      if (index != queue.length - 1)
                        Divider(height: 1, color: theme.dividerColor),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QueueItem extends StatelessWidget {
  final String vehicle;
  final int position;
  final bool isMe;
  final String status;

  const _QueueItem({
    required this.vehicle,
    required this.position,
    required this.status,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final bg = isMe
        ? theme.colorScheme.primary.withAlpha(40)
        : Colors.transparent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: isMe ? BorderRadius.circular(16) : BorderRadius.zero,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMe
                      ? "${l10n.you} (${l10n.vehicleNumber(vehicle)})"
                      : l10n.vehicleNumber(vehicle),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                verticalSpace(2),
                Text(
                  isMe ? l10n.yourTurnSoon : _statusText(status, l10n),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isMe
                        ? theme.colorScheme.primary
                        : theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),

          /// position circle
          CircleAvatar(
            radius: 16,
            backgroundColor: isMe
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
            child: Text(
              "$position",
              style: theme.textTheme.bodySmall?.copyWith(
                color: isMe ? Colors.white : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusText(String status, AppLocalizations l10n) {
    if (status == "Loading") {
      return l10n.loadingPassengers;
    } else {
      return l10n.inQueue;
    }
  }
}
