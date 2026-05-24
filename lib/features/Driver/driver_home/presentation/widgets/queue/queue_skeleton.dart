/// presentation/widgets/queue/queue_skeleton.dart

import 'package:flutter/material.dart';

import '../../../../../../core/widgets/app_shimmer.dart';


class QueueSkeleton extends StatelessWidget {
  const QueueSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          SkeletonBox(
            width: double.infinity,
            height: 80,
            radius: BorderRadius.circular(24),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: SkeletonBox(
                  height: 120,
                  width: double.infinity,
                  radius: BorderRadius.circular(24),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: SkeletonBox(
                  height: 120,
                  width: double.infinity,
                  radius: BorderRadius.circular(24),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          SkeletonBox(
            width: double.infinity,
            height: 420,
            radius: BorderRadius.circular(24),
          ),
        ],
      ),
    );
  }
}