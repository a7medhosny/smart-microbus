import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapTileLayer extends StatelessWidget {
  const MapTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
      subdomains: const ['a', 'b', 'c'],
      userAgentPackageName: 'com.example.smart_microbus',
      tileBuilder: (_, widget, __) {
        return AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 250),
          child: widget,
        );
      },
    );
  }
}