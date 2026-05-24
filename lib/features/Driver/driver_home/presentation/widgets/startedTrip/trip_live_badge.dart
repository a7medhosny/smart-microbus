
import 'package:flutter/material.dart';

class TripLiveBadge extends StatelessWidget {
  const TripLiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.green.withOpacity(.12),
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 6),

          const Text(
            "LIVE",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: .5,
            ),
          ),
        ],
      ),
    );
  }
}