import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

import '../../../../../core/helpers/app_error_helper.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/services/noification_servises.dart';
import '../../../../../core/widgets/app_shimmer.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/queue_item.dart';
import '../cubit/driver_home_cubit.dart';

class InQueueSection extends StatelessWidget {
  const InQueueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listenWhen: (previous, current) =>
          current is GetStationQueueSuccess || current is QueueRealtimeUpdated,

      listener: (context, state) {
        final cubit = context.read<DriverHomeCubit>();

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
          current is GetCurrentPositionLoading ||
          current is GetCurrentPositionError ||
          current is GetCurrentPositionSuccess ||
          current is GetStationQueueLoading ||
          current is GetStationQueueError ||
          current is GetStationQueueSuccess ||
          current is QueueRealtimeUpdated,

      builder: (context, state) {
        final cubit = context.read<DriverHomeCubit>();
        final myPos = cubit.myPosition;
        final queue = cubit.queue;

        /// ================= LOADING =================
        if (state is GetCurrentPositionLoading ||
            state is GetStationQueueLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: _QueueSkeleton(),
          );
        }
        if (queue == null || myPos == null) {
          print(
            'Queue or position is null. Queue: $queue, My Position: $myPos',
          );
          return const Padding(
            padding: EdgeInsets.all(16),
            child: _QueueSkeleton(),
          );
        }

        /// ================= ERROR =================
        if (state is GetCurrentPositionError) {
          return AppErrorWidget(message: state.message, onRetry: () {});
        }

        if (state is GetStationQueueError) {
          return AppErrorWidget(message: state.message, onRetry: () {});
        }

        // final queue = cubit.queue ?? [];

        /// ================= EMPTY =================
        if (queue.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'No drivers in queue.\n\nWaiting for drivers to join the queue.',
                // l10n.noDriversInQueue,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          );
        }

        /// ================= DATA =================
        final vehiclesAhead = cubit.getVehiclesAhead();
        final firstDriver = queue.first.driverId;
        final driverCurrentStatus = cubit.currentStatus;

        final itemHeight = 100.0;
        final maxHeight = 300.0;

        final calculatedHeight = (queue.length * itemHeight).clamp(
          itemHeight,
          maxHeight,
        );

        return Column(
          children: [
            /// ================= STATUS =================
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
                    value: "0",
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

            verticalSpace(20),

            /// ================= LIST HEADER =================
            Row(
              children: [
                Icon(Icons.queue, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(l10n.nextInQueue, style: theme.textTheme.titleMedium),
                const Spacer(),
                Text("${queue.length}"),
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
                      key: ValueKey(item.driverId),
                      children: [
                        _QueueItem(
                          vehicle: item.plateNumber,
                          position: item.position ?? 0,
                          status: item.status,
                          isloading: firstDriver == item.driverId,
                          isMe: isMe,
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

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(scale: isMe ? scale : 1, child: child);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe
              ? theme.colorScheme.primary.withAlpha(30)
              : Colors.transparent,
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
                  ),
                  verticalSpace(2),
                  Text(
                    isloading
                        ? l10n.loadingPassengers
                        : (isMe ? l10n.yourTurnSoon : l10n.inQueue),
                  ),
                ],
              ),
            ),
            CircleAvatar(radius: 16, child: Text("$position")),
          ],
        ),
      ),
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

class _QueueSkeleton extends StatelessWidget {
  const _QueueSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppShimmer(
      child: Column(
        children: [
          const SkeletonBox(width: double.infinity, height: 50),

          const SizedBox(height: 16),

          Row(
            children: const [
              Expanded(child: SkeletonBox(height: 100, width: double.infinity)),
              SizedBox(width: 12),
              Expanded(child: SkeletonBox(height: 100, width: double.infinity)),
            ],
          ),

          const SizedBox(height: 20),

          /// list header
          Row(
            children: const [
              SkeletonBox(width: 120, height: 16),
              Spacer(),
              SkeletonBox(width: 30, height: 16),
            ],
          ),

          const SizedBox(height: 12),

          /// list items
          Column(
            children: [
              _SkeletonListItem(),
              SizedBox(height: 10),
              _SkeletonListItem(),
              SizedBox(height: 10),
              _SkeletonListItem(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonListItem extends StatelessWidget {
  const _SkeletonListItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(width: 140, height: 14),
              SizedBox(height: 6),
              SkeletonBox(width: 80, height: 12),
            ],
          ),
        ),
        SkeletonCircle(size: 32),
      ],
    );
  }
}
