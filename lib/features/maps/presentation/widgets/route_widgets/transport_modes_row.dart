import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/travel_mode.dart';
import '../../cubit/map_cubit.dart';
import 'transport_mode_item.dart';

class TransportModesRow extends StatelessWidget {
  const TransportModesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) =>
          previous.selectedMode != current.selectedMode,
      builder: (context, state) {
        final cubit = context.read<MapCubit>();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TransportModeItem(
              icon: Icons.directions_car,
              selected: state.selectedMode == TravelMode.driving,
              onTap: () async {
                cubit.changeTravelMode(TravelMode.driving);

                await cubit.getRouteBetweenSelectedStations();
              },
            ),

            TransportModeItem(
              icon: Icons.directions_walk,
              selected: state.selectedMode == TravelMode.walking,
              onTap: () async {
                cubit.changeTravelMode(TravelMode.walking);

                await cubit.getRouteBetweenSelectedStations();
              },
            ),

            TransportModeItem(
              icon: Icons.pedal_bike,
              selected: state.selectedMode == TravelMode.cycling,
              onTap: () async {
                cubit.changeTravelMode(TravelMode.cycling);

                await cubit.getRouteBetweenSelectedStations();
              },
            ),
          ],
        );
      },
    );
  }
}