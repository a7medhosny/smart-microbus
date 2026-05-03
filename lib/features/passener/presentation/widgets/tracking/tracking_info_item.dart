import 'package:flutter/material.dart';

class TrackingInfoItem extends StatelessWidget {
  final String title;

  final String value;

  const TrackingInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}