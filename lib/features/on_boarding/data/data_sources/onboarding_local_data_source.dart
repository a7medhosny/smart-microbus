
import '../../../../core/storage/cache_helper.dart';
import '../../../../core/storage/cache_keys.dart';

abstract class OnboardingLocalDataSource {
  Future<void> completeOnboarding();
  bool isOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl
    implements OnboardingLocalDataSource {

  @override
  Future<void> completeOnboarding() async {
    await CacheHelper.insertToCache(
      key: CacheKeys.onboardingKey,
      value: 'true',
    );
  }

  @override
  bool isOnboardingCompleted() {
    return CacheHelper.getCacheData(
          key: CacheKeys.onboardingKey,
        ) ==
        'true';
  }
}