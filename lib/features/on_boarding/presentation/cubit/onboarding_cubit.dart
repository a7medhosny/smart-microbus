import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../data/models/onboarding_model.dart';
import '../../domain/use_cases/complete_onboarding_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CompleteOnboardingUseCase completeOnboardingUseCase;

  OnboardingCubit(this.completeOnboardingUseCase)
    : super(const OnboardingState());

  final PageController pageController = PageController();

  final pages = OnboardingModel.pages;

  void changePage(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Future<void> nextPage(BuildContext context) async {
    if (state.currentIndex == pages.length - 1) {
      await finishOnboarding(context);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> skip(BuildContext context) async {
    await finishOnboarding(context);
  }

  Future<void> finishOnboarding(BuildContext context) async {
    await completeOnboardingUseCase();

    context.pushNamedAndRemoveUntilRoot(Routes.homeScreen);
  }
}
