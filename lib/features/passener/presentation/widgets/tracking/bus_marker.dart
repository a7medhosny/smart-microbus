import 'package:flutter/material.dart';

class BusMarker extends StatelessWidget {
  const BusMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.directions_bus,
        color:
            Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}