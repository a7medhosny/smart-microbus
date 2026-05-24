import '../../domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  const OnboardingModel({
    required super.titleKey,
    required super.subtitleKey,
    required super.animation,
  });

  static List<OnboardingModel> pages = [
    const OnboardingModel(
      titleKey: 'onboardingTitle1',
      subtitleKey: 'onboardingSubtitle1',
      animation: 'assets/animations/gps.json',
    ),
    const OnboardingModel(
      titleKey: 'onboardingTitle2',
      subtitleKey: 'onboardingSubtitle2',
      animation: 'assets/animations/route.json',
    ),
    const OnboardingModel(
      titleKey: 'onboardingTitle3',
      subtitleKey: 'onboardingSubtitle3',
      animation: 'assets/animations/bus.json',
    ),
  ];
}