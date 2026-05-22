import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../maps/domain/entities/driver_location_entity.dart';

import 'bus_marker.dart';
import 'start_marker.dart';
import 'tracking_info_card.dart';

class TrackingMapView extends StatefulWidget {
  final DriverLocationEntity location;

  const TrackingMapView({super.key, required this.location});

  @override
  State<TrackingMapView> createState() => _TrackingMapViewState();
}

class _TrackingMapViewState extends State<TrackingMapView> {
  final MapController _mapController = MapController();

  List<LatLng> get _points {
    return widget.location.coordinates
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

  @override
  void didUpdateWidget(covariant TrackingMapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final points = _points;

    if (points.isEmpty) return;

    _mapController.moveAndRotate(points.last, _mapController.camera.zoom, 0);
  }

  @override
  Widget build(BuildContext context) {
    final points = _points;

    if (points.isEmpty) {
      return const SizedBox();
    }

    final driverPoint = points.last;
    final destinationPoint = points.first;

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(initialCenter: driverPoint, initialZoom: 15),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.smart.microbus',
            ),

            PolylineLayer(
              polylines: [
                Polyline(
                  points: points,
                  strokeWidth: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),

            MarkerLayer(
              markers: [
                Marker(
                  point: destinationPoint,
                  width: 40,
                  height: 40,
                  child: const BusMarker(),
                ),

                Marker(
                  point: driverPoint,
                  width: 50,
                  height: 50,
                  child: const StartMarker(),
                ),
              ],
            ),
          ],
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: TrackingInfoCard(location: widget.location),
        ),
      ],
    );
  }
}
