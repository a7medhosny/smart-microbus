import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class EarningsSummarySection extends StatelessWidget {
  const EarningsSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        final cubit = context.watch<DriverHomeCubit>();
        final earning = cubit.earning;

        if (earning == null) return const SizedBox();

        return GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, "/driverHistory");
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                /// icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(40),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: theme.colorScheme.primary,
                  ),
                ),
                horizontalSpace(16),

                /// text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.todayEarnings,
                        style: theme.textTheme.bodySmall,
                      ),
                      verticalSpace(4),
                      Text(
                        "${earning.totalEarnings} ${earning.currency}",
                        style: theme.textTheme.titleMedium,
                      ),
                      verticalSpace(2),
                      Text(
                        "${earning.totalTrips} ${l10n.trips}",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                /// arrow
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: theme.colorScheme.onSurface.withAlpha(150),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
