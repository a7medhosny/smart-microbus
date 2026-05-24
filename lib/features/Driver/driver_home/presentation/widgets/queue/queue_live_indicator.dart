/// presentation/widgets/queue/queue_live_indicator.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QueueLiveIndicator extends StatelessWidget {
  const QueueLiveIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.greenAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(.6),
                blurRadius: 10,
              ),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .fadeIn(duration: 800.ms)
        .then()
        .fadeOut(duration: 800.ms);
  }
}