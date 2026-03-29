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

      addAuthInterceptor();

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
        final lang = CacheHelper.getCacheData(key: CacheKeys.localeKey) ?? 'en';
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

  static void addAuthInterceptor() {
    if (_dio == null) return;

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

    TokenManager.clearLoginData();
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  bool _isRefreshing = false;

  // =========================
  // 🔹 Request
  // =========================
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    authLog(
      '➡️ Request: ${options.method} ${options.path} | '
      'HasToken: ${TokenManager.token != null}',
    );

    if (TokenManager.token != null) {
      options.headers['Authorization'] = 'Bearer ${TokenManager.token}';
    }

    handler.next(options);
  }

  // =========================
  // 🔹 Error (FIXED)
  // =========================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    authLog(
      '❌ Error: ${err.response?.statusCode} '
      'on ${err.requestOptions.path}',
    );

    /// ❌ مش 401 → عادي
    if (err.response?.statusCode != 401 || TokenManager.refreshToken == null) {
      return handler.reject(err);
    }

    final requestOptions = err.requestOptions;

    /// 🟡 لو في refresh شغال → استنى و retry
    if (_isRefreshing) {
      try {
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }

    _isRefreshing = true;

    authLog('🔄 Starting token refresh...');

    try {
      // =========================
      // 1️⃣ REFRESH TOKEN
      // =========================
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
      );

      authLog('✅ Token refreshed successfully');

      _isRefreshing = false;

      // =========================
      // 2️⃣ RETRY ORIGINAL REQUEST (IMPORTANT)
      // =========================
      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(requestOptions);

      return handler.resolve(response);
    } catch (e) {
      authLog('❌ Token refresh failed: $e');

      _isRefreshing = false;

      TokenManager.clearLoginData();

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );
      AppStateManager.resetAll();

      return handler.reject(err);
    }
  }
}

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

void authLog(String message) {
  debugPrint('🔐 [AuthInterceptor] $message');
}
