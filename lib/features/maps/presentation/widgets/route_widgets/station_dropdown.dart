import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../domain/entities/station_entity.dart';
import '../../cubit/map_cubit.dart';

class StationDropdown extends StatelessWidget {
  final bool isFrom;

  const StationDropdown({super.key, required this.isFrom});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) =>
          previous.fromStation != current.fromStation ||
          previous.toStation != current.toStation ||
          previous.stations != current.stations,
      builder: (context, state) {
        final cubit = context.read<MapCubit>();

        final selectedStation = isFrom ? state.fromStation : state.toStation;

        return Container(
          height: 62.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(
                isFrom
                    ? Icons.radio_button_checked
                    : Icons.location_on_outlined,
                color: isFrom ? colorScheme.primary : colorScheme.error,
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<StationEntity>(
                    dropdownColor: colorScheme.surface,
                    value: selectedStation,
                    hint: Text(
                      isFrom ? loc.tripStartPoint : loc.tripDestination,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    isExpanded: true,
                    items: state.stations.map((station) {
                      return DropdownMenuItem(
                        value: station,
                        child: Text(station.name),
                      );
                    }).toList(),
                    onChanged: (station) async {
                      if (station == null) return;

                      StationEntity? fromStation = state.fromStation;
                      StationEntity? toStation = state.toStation;

                      if (isFrom) {
                        cubit.setFromStation(station);
                        fromStation = station;
                      } else {
                        cubit.setToStation(station);
                        toStation = station;
                      }

                      if (fromStation != null &&
                          toStation != null &&
                          fromStation.id == toStation.id) {
                        ShowToastHelper.showToast(
                          context,
                          loc.startAndEndCannotBeSame,
                          backgroundColor: colorScheme.error,
                        );

                        return;
                      }

                      if (fromStation != null && toStation != null) {
                        await cubit.getRouteBetweenSelectedStations();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
