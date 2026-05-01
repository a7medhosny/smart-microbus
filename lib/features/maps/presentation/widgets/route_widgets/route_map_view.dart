import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_microbus/features/maps/presentation/widgets/map/map_tile_layer.dart';

import '../../../domain/entities/route_info_entity.dart';
import '../../../domain/entities/station_entity.dart';

class RouteMapView extends StatefulWidget {
  final RouteInfoEntity route;

  final StationEntity from;
  final StationEntity to;

  const RouteMapView({
    super.key,
    required this.route,
    required this.from,
    required this.to,
  });

  @override
  State<RouteMapView> createState() => _RouteMapViewState();
}

class _RouteMapViewState extends State<RouteMapView> {
  final MapController mapController = MapController();

  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _fitRoute();
  //   });
  // }

  void _fitRoute() {
    final points = widget.route.routeCoordinates
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    if (points.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(points);

    mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: EdgeInsets.all(60.w)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final points = widget.route.routeCoordinates
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(initialZoom: 13, onMapReady: _fitRoute),
      
      children: [
        const MapTileLayer(),

        PolylineLayer(
          polylines: [
            Polyline(
              points: points,
              strokeWidth: 6.w,
              color: colorScheme.primary,
            ),
          ],
        ),

        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(widget.from.lat, widget.from.lng),
              width: 45.w,
              height: 45.h,
              child: Icon(
                Icons.location_on,
                color: colorScheme.primary,
                size: 42.sp,
              ),
            ),

            Marker(
              point: LatLng(widget.to.lat, widget.to.lng),
              width: 45.w,
              height: 45.h,
              child: Icon(
                Icons.location_on,
                color: colorScheme.error,
                size: 42.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
