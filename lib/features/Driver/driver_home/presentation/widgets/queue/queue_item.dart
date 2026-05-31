/// presentation/widgets/queue/queue_item.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/queue_item.dart';
import '../../cubit/driver_home_cubit.dart';

class QueueItemWidget extends StatelessWidget {
  final QueueItem item;
  final bool isMe;
  final bool isLoading;
  final bool isLast;

  const QueueItemWidget({
    super.key,
    required this.item,
    required this.isMe,
    required this.isLoading,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final driverIndex = context.read<DriverHomeCubit>().getdriverIndex(
      item.driverId,
    ); // Get the index of the driver in the queue

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16,
            child: Column(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLoading
                        ? Colors.greenAccent
                        : theme.colorScheme.primary,
                  ),
                ),

                if (!isLast)
                  Container(
                    width: 2,
                    height: 52,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: theme.colorScheme.primary.withOpacity(.12),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isMe
                    ? theme.colorScheme.primary.withOpacity(.10)
                    : theme.colorScheme.surface.withOpacity(.88),
                border: Border.all(
                  color: isMe
                      ? theme.colorScheme.primary.withOpacity(.28)
                      : theme.colorScheme.primary.withOpacity(.13),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary.withOpacity(.12),
                    ),
                    child: Icon(
                      Icons.directions_bus_rounded,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isMe
                              ? "${l10n.you} • ${item.plateNumber}"
                              : item.plateNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          isLoading
                              ? l10n.loadingPassengers
                              : (isMe ? l10n.yourTurnSoon : l10n.inQueue),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isLoading
                                ? theme.primaryColor
                                : theme.colorScheme.onSurface.withOpacity(.6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                    child: Center(
                      child: Text(
                        "$driverIndex",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
