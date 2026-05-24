import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const OnboardingIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 8,
        expansionFactor: 4,
        activeDotColor: Theme.of(context).colorScheme.primary,
        dotColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(.2),
      ),
    );
  }
}