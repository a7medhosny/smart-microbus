import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';

import '../../cubit/map_cubit.dart';

class RouteResultCard extends StatelessWidget {
  const RouteResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) =>
          previous.routeLoading != current.routeLoading ||
          previous.routeBetweenStations != current.routeBetweenStations,
      builder: (context, state) {
        if (state.routeLoading) {
          return CircularProgressIndicator(
            color: colorScheme.primary,
          );
        }

        final route = state.routeBetweenStations;

        if (route == null) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.route,
                    color: colorScheme.primary,
                  ),

                  horizontalSpace(12),

                  Text(
                    "${route.distanceKm.toStringAsFixed(1)} km",
                    style: textTheme.titleMedium,
                  ),
                ],
              ),

              verticalSpace(18),

              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: colorScheme.tertiary,
                  ),

                  horizontalSpace(12),

                  Text(
                    "${route.etaMinutes.toStringAsFixed(0)} min",
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}