import '../../domain/repositories/onboarding_repository.dart';
import '../data_sources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl
    implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<void> completeOnboarding() async {
    await localDataSource.completeOnboarding();
  }

  @override
  bool isOnboardingCompleted() {
    return localDataSource.isOnboardingCompleted();
  }
}