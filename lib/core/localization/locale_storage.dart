import '../storage/cache_helper.dart';
import '../storage/cache_keys.dart';

class LocaleStorage {

  /// حفظ اللغة
  Future<void> saveLocale(String languageCode) async {
    await CacheHelper.insertToCache(key: CacheKeys.localeKey, value: languageCode);
  }

  /// جلب اللغة
  String? getSavedLocale() {
    return CacheHelper.getCacheData(key: CacheKeys.localeKey);
  }

  /// حذف اللغة (اختياري)
  Future<void> clearLocale() async {
    await CacheHelper.deleteCacheItem(key: CacheKeys.localeKey);
  }
}
