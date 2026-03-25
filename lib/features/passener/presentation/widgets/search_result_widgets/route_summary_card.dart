import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_microbus/features/passener/domain/entities/route_summary_entity.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class RouteSummaryCard extends StatefulWidget {
  final RouteSummaryEntity summary;

  const RouteSummaryCard({super.key, required this.summary});

  @override
  State<RouteSummaryCard> createState() => _RouteSummaryCardState();
}

class _RouteSummaryCardState extends State<RouteSummaryCard> {
  @override
  void initState() {
    super.initState();
    //  context.read<PassengerCubit>().getFavorites(); 

  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///  Header
          Row(
            children: [
              Icon(Icons.alt_route, color: theme.colorScheme.onPrimary),
              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  l10n.tripSummary,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ///  Favorite Button
              BlocBuilder<PassengerCubit, PassengerState>(
                buildWhen: (prev, curr) =>
                    curr is GetFavoritesSuccess ||
                    curr is AddFavoriteSuccess ||
                    curr is RemoveFavoriteSuccess,
                builder: (context, state) {
                  final cubit = context.read<PassengerCubit>();

                  final isFav = cubit.favouriteRoutes.any(
                    (e) => e.routeId == cubit.selectedRouteId,
                  );

                  return IconButton(
                    onPressed: () {
                      if (isFav) {
                        cubit.removeFromFavorites(cubit.selectedRouteId!);
                      } else {
                        cubit.addToFavorites(cubit.selectedRouteId!);
                      }
                    },
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        key: ValueKey(isFav),
                        color: isFav
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.onPrimary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          ///  السعر
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              l10n.priceInCurrency(widget.summary.price),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),

          const SizedBox(height: 16),

          ///  التفاصيل
          Row(
            children: [
              Expanded(
                child: _item(
                  context: context,
                  icon: Icons.route,
                  label: l10n.distance,
                  value: l10n.distanceKm(widget.summary.distanceKm),
                ),
              ),
              Expanded(
                child: _item(
                  context: context,
                  icon: Icons.directions_bus,
                  label: l10n.atStation,
                  value: "${widget.summary.numberOfMicrobusesInQueue}",
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _item(
                  context: context,
                  icon: Icons.access_time,
                  label: l10n.onTheWay,
                  value: "${widget.summary.numberOfMicrobusesOnTheWay}",
                ),
              ),
              Expanded(
                child: _item(
                  context: context,
                  icon: Icons.timer,
                  label: l10n.nearestArrival,
                  value: l10n.minutesShort(widget.summary.nearestArrivalMinutes),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.onPrimary, size: 20),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}