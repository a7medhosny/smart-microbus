import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_microbus/core/theme/app_colors.dart';

import '../../../domain/entities/station_entity.dart';

class MapMarkersLayer extends StatelessWidget {
  final Position? currentPosition;
  final StationEntity? selectedStation;

  const MapMarkersLayer({
    super.key,
    required this.currentPosition,
    required this.selectedStation,
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
            child: Container(
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
            point: LatLng(
              selectedStation!.lat,
              selectedStation!.lng,
            ),
            width: 25.w,
            height: 25.h,
            child: Icon(
              Icons.location_on,
              size: 45.sp,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}