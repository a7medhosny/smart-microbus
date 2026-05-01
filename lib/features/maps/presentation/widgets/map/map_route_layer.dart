import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/entities/route_info_entity.dart';

class MapRouteLayer extends StatelessWidget {
  final RouteInfoEntity route;

  const MapRouteLayer({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PolylineLayer(
      polylines: [
        Polyline(
          points: route.routeCoordinates
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
          strokeWidth: 6.w,
          color: colorScheme.primary,
        ),
      ],
    );
  }
}
