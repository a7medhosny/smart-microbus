/// presentation/widgets/queue/queue_list.dart

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/queue_item.dart';

import 'queue_item.dart';

class QueueList extends StatelessWidget {
  final List<QueueItem> queue;
  final String? currentDriverId;

  const QueueList({
    super.key,
    required this.queue,
    required this.currentDriverId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final height = QueueUiHelper.calculateQueueHeight(queue.length);

    final firstDriver = queue.first.driverId;

    return Column(
      children: [
        verticalSpace(8),

        Row(
          children: [
            Text(
              l10n.nextInQueue,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),

        verticalSpace(14),

        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              height: height.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface.withOpacity(.92),
                    theme.colorScheme.surfaceContainerHighest.withOpacity(.75),
                  ],
                ),
              ),
              child: ImplicitlyAnimatedList<QueueItem>(
                itemData: queue,
                itemEquality: (a, b) => a.driverId == b.driverId,
                padding: const EdgeInsets.symmetric(vertical: 8),

                itemBuilder: (context, item) {
                  final isMe = item.driverId == currentDriverId;

                  return QueueItemWidget(
                        item: item,
                        isMe: isMe,
                        isLoading: firstDriver == item.driverId,
                        isLast: queue.last.driverId == item.driverId,
                      )
                      .animate()
                      .fadeIn(duration: 350.ms)
                      .slideY(
                        begin: .12,
                        end: 0,
                        duration: 350.ms,
                        curve: Curves.easeOutCubic,
                      );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class QueueUiHelper {
  static double calculateQueueHeight(int length) {
    const itemHeight = 72.0;
    const maxHeight = 500.0;

    return ((length * itemHeight) + 32).clamp(itemHeight, maxHeight);
  }
}
