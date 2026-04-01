import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_shimmer.dart';
import 'header_card.dart';

class DriverHomeSkeleton extends StatelessWidget {
  const DriverHomeSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          HeaderCardSkeleton(),
          SizedBox(height: 20),
          _HomeBodySkeleton(),
        ],
      ),
    );
  }
}

class _HomeBodySkeleton extends StatelessWidget {
  const _HomeBodySkeleton();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          /// status container
          const SkeletonBox(
            width: double.infinity,
            height: 50,
          ),

          const SizedBox(height: 16),

          /// cards
          Row(
            children: const [
              Expanded(
                child: SkeletonBox(height: 100, width: double.infinity),
              ),
              SizedBox(width: 12),
              Expanded(
                child: SkeletonBox(height: 100, width: double.infinity),
              ),
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