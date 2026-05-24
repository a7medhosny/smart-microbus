/// presentation/widgets/trip/trip_location_button.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../maps/presentation/cubit/map_cubit.dart';


class TripLocationButton extends StatelessWidget {
  const TripLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.22),
            borderRadius: BorderRadius.circular(18),
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
            icon: const Icon(
              Icons.my_location_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}