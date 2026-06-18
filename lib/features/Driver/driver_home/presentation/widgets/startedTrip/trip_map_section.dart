/// presentation/widgets/trip/trip_map_section.dart
library;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/driver_trip.dart';

import '../../../../../../core/helpers/get_arrival_time.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../maps/domain/entities/route_info_entity.dart';
import '../../../../../maps/presentation/cubit/map_cubit.dart';
import '../../../../../maps/presentation/widgets/map/map_view.dart';

import 'trip_floating_info_card.dart';
import 'trip_location_button.dart';
import 'trip_map_top_bar.dart';

class TripMapSection extends StatelessWidget {
  final DriverTrip trip;

  const TripMapSection({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .30,
            width: double.infinity,
            child: Stack(
              children: [
                const MapView(),

                BlocBuilder<MapCubit, MapState>(
                  builder: (context, state) {
                    final isLoading =
                        state.loading || state.currentPosition == null;

                    if (!isLoading) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      color: Colors.black.withOpacity(.15),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),

                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.25),
                            Colors.transparent,
                            Colors.black.withOpacity(.35),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          BlocSelector<MapCubit, MapState, RouteInfoEntity?>(
            selector: (state) => state.currentRoute,
            builder: (context, route) {
              return Positioned(
                top: 14,
                left: 14,
                right: 14,
                child: TripMapTopBar(
                  arrivalTime: route == null
                      ? "..."
                      : getArrivalTime(
                          context: context,
                          minutes: route.etaMinutes.round(),
                          shortFormat: true,
                        ),
                ),
              );
            },
          ),

          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: BlocSelector<MapCubit, MapState, RouteInfoEntity?>(
              selector: (state) => state.currentRoute,
              builder: (context, route) {
                if (route == null) {
                  return Row(
                    children: [
                      Expanded(
                        child: TripFloatingInfoCard(
                          title: l10n.tripDistance,
                          value: "...",
                          icon: Icons.route_rounded,
                        ),
                      ),

                      horizontalSpace(12),

                      Expanded(
                        child: TripFloatingInfoCard(
                          title: l10n.tripEstimatedTime,
                          value: "...",
                          icon: Icons.timer_rounded,
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: TripFloatingInfoCard(
                        title: l10n.tripDistance,
                        value: l10n.distance_km(route.distanceKm.round()),
                        icon: Icons.route_rounded,
                      ),
                    ),

                    horizontalSpace(12),

                    Expanded(
                      child: TripFloatingInfoCard(
                        title: l10n.tripEstimatedTime,
                        value: getArrivalTime(
                          context: context,
                          minutes: route.etaMinutes.round(),
                          shortFormat: true,
                        ),
                        icon: Icons.timer_rounded,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const Positioned(right: 16, bottom: 72, child: TripLocationButton()),
        ],
      ),
    );
  }
}
