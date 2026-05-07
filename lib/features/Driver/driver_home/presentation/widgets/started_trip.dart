import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../maps/presentation/cubit/map_cubit.dart';
import '../../../../maps/presentation/widgets/map/map_view.dart';
import '../cubit/driver_home_cubit.dart';

class StartedTripSection extends StatelessWidget {
  const StartedTripSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DriverHomeCubit>();
    final l10n = AppLocalizations.of(context)!;
    final trip = cubit.currentTrip;

    final theme = Theme.of(context);
    if (trip == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ================= TRIP STATUS =================
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                /// BUS ICON
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.directions_bus,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),

                horizontalSpace(12),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.tripStarted,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),

                      verticalSpace(4),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14.sp,
                            color: theme.colorScheme.primary,
                          ),

                          horizontalSpace(4),

                          Expanded(
                            child: Text(
                              l10n.tripStartedSince("10"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                horizontalSpace(8),

                /// ACTIVE BADGE
                FittedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      l10n.tripActiveNow,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        /// ================= MAP =================
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    const MapView(),

                    /// 👇 Loading Overlay
                    BlocBuilder<MapCubit, MapState>(
                      builder: (context, state) {
                        final isLoading =
                            state.loading ||
                            state.currentPosition == null;

                        if (!isLoading) return const SizedBox.shrink();

                        return Container(
                          color: Colors.black.withOpacity(0.2),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// overlay
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withOpacity(.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      final cubit = context.read<MapCubit>();

                      if (cubit.state.currentPosition != null) {
                        cubit.currentMapController.move(
                          LatLng(
                            cubit.state.currentPosition!.latitude,
                            cubit.state.currentPosition!.longitude,
                          ),
                          16,
                        );
                      }
                    },
                    icon: Icon(Icons.my_location),
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        /// ================= ROUTE =================
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _routeItem(
                  context,
                  icon: Icons.circle,
                  color: theme.colorScheme.primary,
                  title: l10n.tripStartPoint,
                  value: trip.routeFrom ?? "",
                ),

                _routeItem(
                  context,
                  icon: Icons.location_on,
                  color: Colors.green,
                  title: l10n.tripDestination,
                  value: trip.routeTo ?? "",
                  isLast: true,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        /// ================= INFO =================
        Row(
          children: [
            Expanded(
              child: _infoCard(
                context,
                icon: Icons.route,
                title: l10n.tripDistance,
                value: "${trip.distanceKm} KM",
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: _infoCard(
                context,
                icon: Icons.timer,
                title: l10n.tripEstimatedTime,
                value: "${trip.estimatedArrivalMinutes} mins",
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ROUTE ITEM
  Widget _routeItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    bool isLast = false,
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TIMELINE
        Column(
          children: [
            verticalSpace(5),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            verticalSpace(4),
            if (!isLast)
              Container(
                width: 2,
                height: 70,
                color: theme.colorScheme.outlineVariant,
              ),
          ],
        ),

        const SizedBox(width: 12),

        /// TEXT CONTENT
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// INFO CARD
  Widget _infoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary),

            const SizedBox(height: 10),

            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(title, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
