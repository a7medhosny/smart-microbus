import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/widgets/app_shimmer.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final name = TokenManager.userName;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withAlpha(180),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          /// Avatar
          InkWell(
            onTap: () {
              context.read<DriverHomeCubit>().changeBottomNavIndex(2);
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: theme.colorScheme.onPrimary.withAlpha(40),
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),

          horizontalSpace(12),

          /// Info
          Expanded(
            child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
              builder: (context, state) {
                final cubit = context.watch<DriverHomeCubit>();
                final currentStatus = cubit.currentStatus;
                final status = currentStatus?.status;

                /// ===== DEFAULT VALUES =====
                String subtitle = l10n.tripActiveNow;
                String? route;

                /// ===== HANDLE STATES =====
                if (status == 'OnTrip') {
                  final trip = currentStatus?.trip;

                  route = "${trip?.routeFrom ?? '-'} → ${trip?.routeTo ?? '-'}";

                  subtitle = l10n.notInQueue;
                } else if (status == 'InQueue') {
                  final queue = currentStatus?.queue;

                  route =
                      "${queue?.routeFrom ?? '-'} → ${queue?.routeTo ?? '-'}";

                  subtitle = cubit.isMyTurn()
                      ? l10n.loadingPassengers
                      : l10n.inQueue;
                } else {
                  /// Idle / null
                  subtitle = l10n.tripActiveNow;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text(
                      l10n.helloDriver(name ?? ''),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    verticalSpace(6),

                    /// Route (only if exists)
                    if (route != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.alt_route,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              route,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                    verticalSpace(4),

                    /// Status Text
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// History
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withOpacity(.2),
            child: IconButton(
              icon: const Icon(Icons.history, size: 20, color: Colors.white),
              onPressed: () {
                context.read<DriverHomeCubit>().changeBottomNavIndex(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCardSkeleton extends StatelessWidget {
  const HeaderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Row(
          children: const [
            SkeletonCircle(size: 48),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 140, height: 16),
                  SizedBox(height: 8),
                  SkeletonBox(width: 100, height: 12),
                ],
              ),
            ),
            SkeletonCircle(size: 40),
          ],
        ),
      ),
    );
  }
}
