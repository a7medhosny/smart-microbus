import 'dart:async';
import 'package:smart_microbus/core/auth/token_helper.dart';
import 'package:smart_microbus/core/storage/cache_helper.dart';
import '../storage/cache_keys.dart';

class TokenManager {
  // عشان السيجنال ار يوصله ان التوكين اتجدد ويعمل رفريش للكونكشن
  static final _tokenRefreshController = StreamController<void>.broadcast();

  static Stream<void> get onTokenRefreshed => _tokenRefreshController.stream;

  static String? get token => CacheHelper.getCacheData(key: CacheKeys.token);
  static String? get refreshToken =>
      CacheHelper.getCacheData(key: CacheKeys.refreshToken);
  static String? get userName =>
      CacheHelper.getCacheData(key: CacheKeys.userName);
  static String? get phone => CacheHelper.getCacheData(key: CacheKeys.phone);
  static String? get userId => CacheHelper.getCacheData(key: CacheKeys.userId);
  static String? get role => CacheHelper.getCacheData(key: CacheKeys.role);

  static DateTime? get expiration {
    final expirationStr = CacheHelper.getCacheData(key: CacheKeys.expiration);
    if (expirationStr == null) return null;
    return DateTime.tryParse(expirationStr);
  }

  static bool isTokenExpired() {
    final exp = expiration;
    if (exp == null) return true;
    return exp.isBefore(DateTime.now());
  }

  static Future<void> saveLoginData({
    required String token,
    required String refreshToken,
    required String expiration,
    required String refreshTokenExpirationDateTime,
    required String userName,
    required String phone,
    required String userId,
    bool isRefresh = false,
  }) async {
    await CacheHelper.insertToCache(key: CacheKeys.token, value: token);
    await CacheHelper.insertToCache(
      key: CacheKeys.refreshToken,
      value: refreshToken,
    );
    await CacheHelper.insertToCache(
      key: CacheKeys.expiration,
      value: expiration,
    );
    await CacheHelper.insertToCache(
      key: CacheKeys.refreshTokenExpiration,
      value: refreshTokenExpirationDateTime,
    );
    await CacheHelper.insertToCache(key: CacheKeys.userName, value: userName);
    await CacheHelper.insertToCache(key: CacheKeys.phone, value: phone);
    await CacheHelper.insertToCache(key: CacheKeys.userId, value: userId);
    await CacheHelper.insertToCache(
      key: CacheKeys.role,
      value: TokenHelper.extractRoles(token),
    );

    if (isRefresh) {
      _tokenRefreshController.add(null);
    }
  }

  static Future<void> clearLoginData() async {
    await CacheHelper.deleteCacheItem(key: CacheKeys.token);
    await CacheHelper.deleteCacheItem(key: CacheKeys.refreshToken);
    await CacheHelper.deleteCacheItem(key: CacheKeys.expiration);
    await CacheHelper.deleteCacheItem(key: CacheKeys.userId);
    await CacheHelper.deleteCacheItem(key: CacheKeys.userName);
    await CacheHelper.deleteCacheItem(key: CacheKeys.phone);
  }
}
