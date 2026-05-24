import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';


import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/background_gradient.dart';
import '../widgets/onboarding_bottom_section.dart';
import '../widgets/onboarding_page_view_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BackgroundGradient(
        child: SafeArea(
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            buildWhen: (previous, current) =>
                previous.currentIndex != current.currentIndex,
            builder: (context, state) {
              final cubit = context.read<OnboardingCubit>();

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      onPageChanged: cubit.changePage,
                      itemCount: cubit.pages.length,
                      itemBuilder: (context, index) {
                        final item = cubit.pages[index];

                        return OnboardingPageViewItem(
                          item: item,
                          title: _getTitle(
                            index,
                            localizations,
                          ),
                          subtitle: _getSubtitle(
                            index,
                            localizations,
                          ),
                        );
                      },
                    ),
                  ),
                  OnboardingBottomSection(
                    next: localizations.next,
                    getStarted:
                        localizations.getStarted,
                    skip: localizations.skip,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _getTitle(
    int index,
    localizations,
  ) {
    switch (index) {
      case 0:
        return localizations.onboardingTitle1;
      case 1:
        return localizations.onboardingTitle2;
      default:
        return localizations.onboardingTitle3;
    }
  }

  String _getSubtitle(
    int index,
    localizations,
  ) {
    switch (index) {
      case 0:
        return localizations.onboardingSubtitle1;
      case 1:
        return localizations.onboardingSubtitle2;
      default:
        return localizations.onboardingSubtitle3;
    }
  }
}