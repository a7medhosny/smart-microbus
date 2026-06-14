import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../cubit/driver_home_cubit.dart';
import 'trip_loading_widget.dart';
import 'trip_map_section.dart';
import 'trip_route_section.dart';
import 'trip_status_card.dart';

class StartedTripSection extends StatelessWidget {
  const StartedTripSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DriverHomeCubit>();
    final l10n = AppLocalizations.of(context)!;

    final trip = cubit.currentTrip;

    if (trip == null) {
      return const TripLoadingWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       TripStatusCard(
  startedAt: trip.startedAt,
),

        verticalSpace(18),

        TripMapSection(trip: trip),

        verticalSpace(18),

        TripRouteSection(
          routeFrom: trip.routeFrom ?? "",
          routeTo: trip.routeTo ?? "",
          startTitle: l10n.tripStartPoint,
          endTitle: l10n.tripDestination,
        ),
      ],
    );
  }
}
