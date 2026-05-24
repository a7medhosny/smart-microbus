
import 'package:flutter/material.dart';

class TripLoadingWidget extends StatelessWidget {
  const TripLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}