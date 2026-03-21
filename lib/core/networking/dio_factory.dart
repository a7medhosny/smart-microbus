import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:smart_microbus/core/storage/cache_helper.dart';
import 'package:smart_microbus/core/storage/cache_keys.dart';
import 'package:smart_microbus/features/register/data/datasource/register_api_service.dart';

import '../../features/register/data/models/auth_response_model.dart';
import '../../features/register/data/models/refresh_token_request_model.dart';
import '../auth/token_helper.dart';
import '../auth/token_manager.dart';
import '../di/dependency_injection.dart';
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

// testRefreshToken() async {
//   try {
//     final response = await _refreshToken();
//     print('Token refreshed successfully: ${response.token}');
//   } catch (e) {
//     print('Failed to refresh token: $e');
//   }
// }

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
    _logDioError(err);
    authLog('❌ Error: $statusCode on ${err.requestOptions.path}');

    // ❌ لو مش 401 → رجعه عادي
    if (statusCode != 401 || TokenManager.refreshToken == null) {
      return handler.reject(err);
    }

    final requestOptions = err.requestOptions;

    try {
      // =========================
      // 🔥 لو فيه refresh شغال → استنى
      // =========================
      if (_isRefreshing) {
        authLog('⏳ Waiting for token refresh...');
        await _refreshCompleter?.future;

        // 🔁 retry بعد ما التوكن يتجدد
        requestOptions.headers['Authorization'] =
            'Bearer ${TokenManager.token}';

        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      }

      // =========================
      // 🔥 ابدأ refresh
      // =========================
      _isRefreshing = true;
      _refreshCompleter = Completer();

      authLog('🔄 Starting token refresh...');

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
      _refreshCompleter?.complete();

      // =========================
      // 🔁 retry original request
      // =========================
      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(requestOptions);

      return handler.resolve(response);
    } catch (e) {
      authLog('❌ Token refresh failed: $e');

      _isRefreshing = false;
      _refreshCompleter?.completeError(e);

      TokenManager.clearLoginData();

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );

      return handler.reject(err);
    }
  }
}

void _logDioError(DioException err) {
  final request = err.requestOptions;
  final response = err.response;

  authLog('''
================= ❌ DIO ERROR =================
🔗 URL: ${request.baseUrl}${request.path}
📌 Method: ${request.method}

📤 Headers:
${request.headers}

📤 Query:
${request.queryParameters}

📤 Body:
${request.data}

-----------------------------------------------
📥 Status Code: ${response?.statusCode}

📥 Response:
${response?.data}

-----------------------------------------------
⚠️ Dio Type: ${err.type}
⚠️ Message: ${err.message}

===============================================
''');
}

Future<AuthResponseModel> _refreshToken() async {
  final lang = CacheHelper.getCacheData(key: CacheKeys.localeKey) ?? 'en';

  final refreshDio = Dio()..options.validateStatus = (status) => true;
    refreshDio.interceptors.add(
    PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: false,
      maxWidth: 90,
    ),
  );

  refreshDio.options.headers = {
    'Accept-Language': lang,
    'Content-Type': 'application/json',
  };

  print("TOKEN: ${TokenManager.token}");
  print("REFRESH: ${TokenManager.refreshToken}");

  final response = await refreshDio.post(
    "https://smart-microbus.runasp.net/api/v1/account/generate-new-jwt-token",
    data: {
      "token": TokenManager.token ?? '',
      "refreshToken": TokenManager.refreshToken ?? '',
    },
  );

  print("REFRESH RESPONSE: ${response.data}");

  if (response.statusCode != 200) {
    throw Exception("Refresh failed: ${response.data}");
  }

  return AuthResponseModel.fromJson(response.data);
}

void authLog(String message) {
  debugPrint('🔐 [AuthInterceptor] $message');
}
