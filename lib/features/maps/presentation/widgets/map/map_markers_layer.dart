import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/entities/station_entity.dart';
import '../../../domain/enums/map_mode.dart';

class MapMarkersLayer extends StatelessWidget {
  final Position? currentPosition;
  final StationEntity? selectedStation;
  final MapMode mode;

  const MapMarkersLayer({
    super.key,
    required this.currentPosition,
    required this.selectedStation,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MarkerLayer(
      markers: [
        if (currentPosition != null)
          Marker(
            point: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
            width: 25.w,
            height: 25.h,
            child: mode == MapMode.driver
                ? Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: colorScheme.primary.withAlpha(60),
                    ),
                    child: Icon(
                      Icons.directions_car,
                      color: colorScheme.primary,
                      size: 25.sp,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 4.w,
                      ),
                      color: colorScheme.primary,
                    ),
                  ),
          ),

        if (selectedStation != null)
          Marker(
            point: LatLng(selectedStation!.lat, selectedStation!.lng),
            width: 25.w,
            height: 25.h,
            child: Icon(Icons.location_on, size: 45.sp, color: Colors.red),
          ),
      ],
    );
  }
}
