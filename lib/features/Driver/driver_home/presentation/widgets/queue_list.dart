import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_item.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/services/noification_servises.dart';

class QueueListSection extends StatelessWidget {
  const QueueListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listenWhen: (previous, current) =>
          current is GetStationQueueSuccess || current is QueueRealtimeUpdated,

      listener: (context, state) {
        final cubit = context.read<DriverHomeCubit>();
        final l10n = AppLocalizations.of(context)!;

        if (cubit.isMyTurn() && !cubit.turnNotified) {
          cubit.turnNotified = true;

          NotificationService.showNotification(
            title: l10n.yourTurnNotificationTitle,
            body: l10n.yourTurnNotificationBody,
          );
        }

        if (!cubit.isMyTurn()) {
          cubit.turnNotified = false;
        }
      },

      buildWhen: (previous, current) =>
          current is GetStationQueueSuccess || current is QueueRealtimeUpdated,

      builder: (context, state) {
        final cubit = context.read<DriverHomeCubit>();

        final queue = cubit.queue;
        String firstDriver = "";
        if (queue != null && queue.isNotEmpty) {
          firstDriver = queue.first.driverId;
        }
        final myPos = cubit.myPosition;
        final driverCurrentStatus = cubit.currentStatus;

        /// ================= LOADING =================
        if (queue == null || myPos == null) {
          print(
            'Queue or position is null. Queue: $queue, My Position: $myPos',
          );
          return Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }

        /// ================= EMPTY QUEUE =================
        if (queue.isEmpty) {
          Future.microtask(() {
            cubit.getCurrentPosition();
          });

          return Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }

        /// ================= HEIGHT =================
        final itemHeight = 100.0;
        final maxHeight = 300.h;

        final calculatedHeight = (queue.length * itemHeight).clamp(
          itemHeight,
          maxHeight,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= HEADER =================
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.queue,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.nextInQueue,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${queue.length}",
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ================= LIST =================
            Container(
              height: calculatedHeight.h,
              decoration: BoxDecoration(
                color: theme.cardTheme.color ?? theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.dividerColor.withAlpha(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(8),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ImplicitlyAnimatedList<QueueItem>(
                  itemData: queue,
                  itemEquality: (a, b) => a.driverId == b.driverId,
                  padding: const EdgeInsets.symmetric(vertical: 6),

                  /// ================= ITEM =================
                  ///
                  itemBuilder: (context, item) {
                    final isMe = item.driverId == driverCurrentStatus?.driverId;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _QueueItem(
                          vehicle: item.plateNumber,
                          position: item.position ?? 0,
                          status: item.status,
                          isloading: firstDriver == item.driverId,
                          isMe: isMe,
                          // isMyTurn: cubit.isMyTurn() && isMe,
                        ),
                        if (queue.last.driverId != item.driverId)
                          Divider(
                            height: 1,
                            color: theme.dividerColor.withAlpha(30),
                          ),
                      ],
                    );
                  },
                ),
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
  final bool isloading;
  final String status;

  const _QueueItem({
    required this.vehicle,
    required this.position,
    required this.status,
    required this.isloading,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final bg = isMe
        ? theme.colorScheme.primary.withAlpha(30)
        : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: isMe ? BorderRadius.circular(16) : BorderRadius.zero,
      ),
      child: Row(
        children: [
          /// ================= VEHICLE INFO =================
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
                  isloading
                      ? l10n.loadingPassengers
                      : (isMe ? l10n.yourTurnSoon : l10n.inQueue),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isMe
                        ? theme.colorScheme.primary
                        : theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),

          /// ================= POSITION =================
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isMe
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
              border: Border.all(color: theme.dividerColor.withAlpha(60)),
            ),
            child: Text(
              "$position",
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
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
    }
    return l10n.inQueue;
  }
}
