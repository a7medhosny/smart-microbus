import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/route_info_entity.dart';
import '../../../domain/entities/station_entity.dart';
import '../../cubit/map_cubit.dart';
import 'info_chip.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    return BlocSelector<
      MapCubit,
      MapState,
      ({bool routeLoading, StationEntity? station, RouteInfoEntity? route})
    >(
      selector: (state) => (
        routeLoading: state.routeLoading,
        station: state.selectedStation,
        route: state.currentRoute,
      ),
      builder: (context, data) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 150.h,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          ),
          child: data.station == null
              ? Center(
                  child: Text(
                    loc.selectStationToViewDetails,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.station!.name, style: textTheme.titleLarge),

                    verticalSpace(14),

                    if (data.routeLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      )
                    else if (data.route != null)
                      Row(
                        children: [
                          InfoChip(
                            text:
                                "${data.route!.distanceKm.toStringAsFixed(1)} km",
                          ),

                          horizontalSpace(12),

                          InfoChip(
                            text:
                                "${data.route!.etaMinutes.toStringAsFixed(0)} min",
                          ),
                        ],
                      )
                    else
                      Text(
                        loc.routeInformationUnavailable,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
