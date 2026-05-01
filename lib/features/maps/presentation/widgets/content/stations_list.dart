import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/station_entity.dart';
import '../../cubit/map_cubit.dart';

class StationsList extends StatelessWidget {
  const StationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return BlocSelector<MapCubit, MapState, List<StationEntity>>(
      selector: (state) => state.stations,
      builder: (context, stations) {
        final cubit = context.read<MapCubit>();

        return SizedBox(
          height: 55.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            scrollDirection: Axis.horizontal,
            itemCount: stations.length + 1,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (_, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: cubit.getNearestStationRoute,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(.12),
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: colorScheme.primary),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.near_me,
                          size: 18.sp,
                          color: colorScheme.primary,
                        ),

                        SizedBox(width: 8.w),

                        Text(
                          loc.nearest,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final station = stations[index - 1];

              return GestureDetector(
                onTap: () async {
                  await cubit.getStationRoute(station);

                  cubit.moveToStation(station);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18.sp,
                        color: colorScheme.primary,
                      ),

                      SizedBox(width: 8.w),

                      Text(station.name, style: textTheme.bodyMedium),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
