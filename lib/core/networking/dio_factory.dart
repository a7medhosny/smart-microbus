import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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
      // _dio!.interceptors.add(_loggerInterceptor());
      // _dio!.interceptors.add(_addAPIKey());

      addAuthInterceptor();
      // addDioInterceptor();
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

  static Interceptor _loggerInterceptor() {
    return LogInterceptor(
      requestBody: true,
      requestHeader: true,
      request: true,
    );
  }

  static void addDioInterceptor() {
    _dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  // static Interceptor _addAPIKey() {
  //   return InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       options.headers['X-API-KEY'] =
  //           "ovuPaA2bJcgksW6yONrlDYtKweqihHfGnd9pI1FMVRmCTzE7UBx03SXZ8QL5j4";
  //       handler.next(options);
  //     },
  //   );
  // }

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

Future<void> testRefreshToken() async {
  try {
    final response = await _refreshToken();
    print('Token refreshed successfully: ${response.token}');
  } catch (e) {
    print('Failed to refresh token: $e');
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  bool _isRefreshing = false;
  final List<RequestOptions> _retryQueue = [];

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
  // 🔹 Error
  // =========================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    authLog(
      '❌ Error: ${err.response?.statusCode} '
      'on ${err.requestOptions.path}',
    );

    // =========================
    // ❌ Not 401 → Show SnackBar
    // =========================
    if (err.response?.statusCode != 401 || TokenManager.refreshToken == null) {
      authLog('❌ Non-401 error or no refresh token. Showing error snackbar.');
      // showGlobalSnackBar("Something went wrong. Please try again.");

      return handler.reject(err);
    }

    final requestOptions = err.requestOptions;

    if (_isRefreshing) {
      _retryQueue.add(requestOptions);
      return;
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
        userId: TokenHelper.extractUserId(authResponse.token ?? '') ?? '',
        phone: authResponse.phone ?? '',
      );

      authLog('✅ Token refreshed successfully');

      // =========================
      // 2️⃣ RETRY ORIGINAL REQUEST
      // =========================
      Response<dynamic>? response;

      try {
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        response = await dio.fetch(requestOptions);
      } catch (e) {
        authLog('❌ Original request retry failed: $e');

        // showGlobalSnackBar("Request failed. Please try again.");
      }

      // =========================
      // 3️⃣ RETRY QUEUED REQUESTS
      // =========================
      for (final req in _retryQueue) {
        try {
          req.headers['Authorization'] = 'Bearer $newToken';

          await dio.fetch(req);
        } catch (e) {
          authLog('❌ Retry failed: ${req.path} → $e');

          // showGlobalSnackBar("Some requests failed. Please try again.");
        }
      }

      _retryQueue.clear();
      _isRefreshing = false;

      if (response != null) {
        return handler.resolve(response);
      } else {
        return handler.reject(err);
      }
    }
    // =========================
    // ❌ Refresh Failed → Logout ONLY
    // =========================
    catch (e) {
      authLog('❌ Token refresh failed: $e');

      _isRefreshing = false;

      TokenManager.clearLoginData();

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );

      handler.reject(err);
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
