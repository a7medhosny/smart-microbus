import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:smart_microbus/core/helpers/app_state_manager.dart';
import 'package:smart_microbus/core/storage/cache_helper.dart';
import 'package:smart_microbus/core/storage/cache_keys.dart';

import '../../features/register/data/models/auth_response_model.dart';
import '../auth/token_helper.dart';
import '../auth/token_manager.dart';
import '../routing/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio()
        ..options.connectTimeout = const Duration(seconds: 30)
        ..options.receiveTimeout = const Duration(seconds: 30);

      _dio!.interceptors.add(_addLanguageHeader());

      _dio!.interceptors.add(AuthInterceptor(_dio!));

      _dio!.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onResponse: (response, handler) {
            if (response.statusCode == 204) {
              response.data = [];
            }
            handler.next(response);
          },
        ),
      );
    }

    return _dio!;
  }

  static Interceptor _addLanguageHeader() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final lang = CacheHelper.getCacheData(key: CacheKeys.localeKey) ?? 'ar';
        options.headers['Accept-Language'] = lang;
        handler.next(options);
      },
    );
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    if (_dio == null) return;

    _dio!.options.headers['Authorization'] = 'Bearer $token';

    final alreadyAdded = _dio!.interceptors.any((i) => i is AuthInterceptor);

    if (!alreadyAdded) {
      _dio!.interceptors.add(AuthInterceptor(_dio!));
    }
  }

  static void removeAuthInterceptor() {
    if (_dio == null) return;

    _dio!.interceptors.removeWhere(
      (interceptor) => interceptor is AuthInterceptor,
    );

    _dio!.options.headers.remove('Authorization');
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  // =========================
  // 🔹 Request
  // =========================
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    authLog(
      '➡️ ${options.method} ${options.path} | Token: ${TokenManager.token != null}',
    );

    /// لو فيه refresh شغال → استنى
    if (_isRefreshing && _refreshCompleter != null) {
      _refreshCompleter!.future.then((_) {
        options.headers['Authorization'] = 'Bearer ${TokenManager.token}';
        handler.next(options);
      });
      return;
    }

    if (TokenManager.token != null) {
      options.headers['Authorization'] = 'Bearer ${TokenManager.token}';
    }

    handler.next(options);
  }

  // =========================
  // 🔹 Error
  // =========================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    authLog('❌ $statusCode on ${err.requestOptions.path}');

    /// مش 401 → سيبه يعدي
    if (statusCode != 401) {
      return handler.next(err);
    }

    /// لو مفيش refresh token → logout
    if (TokenManager.refreshToken == null) {
      return _handleLogout(handler, err);
    }

    final requestOptions = err.requestOptions;

    try {
      /// لو refresh شغال → استنى
      if (_isRefreshing) {
        await _refreshCompleter!.future;

        requestOptions.headers['Authorization'] =
            'Bearer ${TokenManager.token}';

        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      }

      /// ابدأ refresh
      _isRefreshing = true;
      _refreshCompleter = Completer();

      authLog('🔄 Refreshing token...');

      final authResponse = await _refreshToken();

      final newToken = authResponse.token ?? '';

      await TokenManager.saveLoginData(
        token: newToken,
        refreshToken: authResponse.refreshToken ?? '',
        expiration: authResponse.expiration ?? '',
        refreshTokenExpirationDateTime:
            authResponse.refreshTokenExpirationDateTime ?? '',
        userName: authResponse.userName ?? '',
        userId: TokenHelper.extractUserId(newToken) ?? '',
        phone: authResponse.phone ?? '',
        isRefresh: true,
      );

      authLog('✅ Refresh success');

      _isRefreshing = false;
      _refreshCompleter!.complete();

      /// retry
      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(requestOptions);

      return handler.resolve(response);
    } catch (e) {
      authLog('❌ Refresh failed');

      _isRefreshing = false;
      _refreshCompleter?.completeError(e);

      return _handleLogout(handler, err);
    }
  }

  // =========================
  // 🔴 Logout
  // =========================
  Future<void> _handleLogout(
    ErrorInterceptorHandler handler,
    DioException err,
  ) async {
    TokenManager.clearLoginData();

    DioFactory.removeAuthInterceptor();

    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );

    AppStateManager.resetAll();

    return handler.reject(err);
  }
}

// =========================
// 🔄 Refresh API
// =========================
Future<AuthResponseModel> _refreshToken() async {
  final lang = CacheHelper.getCacheData(key: CacheKeys.localeKey) ?? 'en';

  final refreshDio = Dio();

  refreshDio.options.headers = {
    'Accept-Language': lang,
    'Content-Type': 'application/json',
  };

  final response = await refreshDio.post(
    "https://smart-microbus.runasp.net/api/v1/account/generate-new-jwt-token",
    data: {
      "token": TokenManager.token ?? '',
      "refreshToken": TokenManager.refreshToken ?? '',
    },
  );

  return AuthResponseModel.fromJson(response.data);
}

Future<bool> initializeAuth() async {
  /// مفيش token → مش logged in
  if (TokenManager.token == null) return false;

  /// لو access token لسه شغال → تمام
  if (!TokenManager.isTokenExpired()) {
    return true;
  }

  /// access token expired → نشوف refresh
  if (TokenManager.refreshToken == null ||
      TokenManager.isRefreshTokenExpired()) {
    return false;
  }

  try {
    authLog('🚀 Initial refresh before app start');

    final res = await _refreshToken();

    final newToken = res.token ?? '';

    await TokenManager.saveLoginData(
      token: newToken,
      refreshToken: res.refreshToken ?? '',
      expiration: res.expiration ?? '',
      refreshTokenExpirationDateTime: res.refreshTokenExpirationDateTime ?? '',
      userName: res.userName ?? '',
      userId: TokenHelper.extractUserId(newToken) ?? '',
      phone: res.phone ?? '',
      isRefresh: true,
    );

    authLog('✅ Initial refresh success');

    return true;
  } catch (e) {
    authLog('❌ Initial refresh failed');
    return false;
  }
}

void authLog(String message) {
  debugPrint('🔐 $message');
}
