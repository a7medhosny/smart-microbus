import 'package:smart_microbus/core/networking/dio_factory.dart';
import 'package:smart_microbus/core/storage/cache_helper.dart';
import 'package:smart_microbus/core/storage/cache_keys.dart';

enum SessionState { guest, authenticated, unauthenticated }

class SessionManager {
  static Future<void> enterGuest() async {
    await CacheHelper.insertToCache(key: CacheKeys.guestId, value: "guest");

    DioFactory.removeAuthInterceptor();
  }

  static bool get isGuest {
    return CacheHelper.getCacheData(key: CacheKeys.guestId) != null;
  }

  static bool get isLoggedIn {
    return CacheHelper.getCacheData(key: CacheKeys.token) != null;
  }

  static Future<SessionState> initializeSession() async {
    if (isGuest) {
      return SessionState.guest;
    }

    final loggedIn = await initializeAuth();

    if (loggedIn) {
      return SessionState.authenticated;
    }

    return SessionState.unauthenticated;
  }
}
