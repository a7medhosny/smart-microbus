import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/entities/route_info_entity.dart';
import '../../../domain/entities/station_entity.dart';
import '../../cubit/map_cubit.dart';
import 'map_markers_layer.dart';
import 'map_route_layer.dart';
import 'map_tile_layer.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      MapCubit,
      MapState,
      ({
        StationEntity? selectedStation,
        RouteInfoEntity? route,
        Position? position,
      })
    >(
      selector: (state) => (
        selectedStation: state.selectedStation,
        route: state.currentRoute,
        position: state.currentPosition,
      ),
      builder: (context, data) {
        final cubit = context.read<MapCubit>();

        final center = data.position != null
            ? LatLng(data.position!.latitude, data.position!.longitude)
            : const LatLng(28.494794, 30.806179);

        return FlutterMap(
          mapController: cubit.mapController,
          options: MapOptions(initialCenter: center, initialZoom: 14),
          children: [
            const MapTileLayer(),

            if (data.route != null) MapRouteLayer(route: data.route!),

            MapMarkersLayer(
              currentPosition: data.position,
              selectedStation: data.selectedStation,
            ),
          ],
        );
      },
    );
  }
}
