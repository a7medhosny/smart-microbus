import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/onboarding_cubit.dart';
import 'onboarding_indicator.dart';
import 'onboarding_next_button.dart';
import 'onboarding_skip_button.dart';

class OnboardingBottomSection extends StatelessWidget {
  final String next;
  final String getStarted;
  final String skip;

  const OnboardingBottomSection({
    super.key,
    required this.next,
    required this.getStarted,
    required this.skip,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnboardingCubit>();

    final isLast =
        cubit.state.currentIndex == cubit.pages.length - 1;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingIndicator(
            controller: cubit.pageController,
            count: cubit.pages.length,
          ),
          const SizedBox(height: 24),
          OnboardingNextButton(
            title: isLast ? getStarted : next,
            onTap: () => cubit.nextPage(context),
          ),
          const SizedBox(height: 12),
          if (!isLast)
            OnboardingSkipButton(
              title: skip,
              onTap: () => cubit.skip(context),
            ),
        ],
      ),
    );
  }
}