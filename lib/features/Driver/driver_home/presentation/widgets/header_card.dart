import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

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
          /// Driver Avatar
          InkWell(
            onTap: () {
              context.read<DriverHomeCubit>().changeBottomNavIndex(2);
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: theme.colorScheme.onPrimary.withAlpha(40),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),

          horizontalSpace(12),

          /// Driver Info
          Expanded(
            child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
              builder: (context, state) {
                final cubit = context.watch<DriverHomeCubit>();
                final position = cubit.myPosition;

                /// Driver outside queue
                if (position == null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.helloDriver(name ?? ''),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      verticalSpace(6),

                      Text(
                        l10n.notInQueue,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  );
                }

                final routeFrom = position.routeFrom ?? '-';
                final routeTo = position.routeTo ?? '-';
                final route = "$routeFrom → $routeTo";

                final isInQueue =
                    position.queueId != '00000000-0000-0000-0000-000000000000';

                final isMyTurn = cubit.isMyTurn();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.helloDriver(name ?? ''),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    verticalSpace(6),

                    /// Route Badge
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

                    Text(
                      isMyTurn
                          ? l10n.loadingPassengers
                          : isInQueue
                          ? l10n.inQueue
                          : l10n.notInQueue,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Trip History Icon
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
