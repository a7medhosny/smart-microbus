import 'package:flutter/material.dart';

class StartMarker extends StatelessWidget {
  const StartMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.location_on,
        color: Theme.of(context)
            .colorScheme
            .onSecondary,
      ),
    );
  }
}