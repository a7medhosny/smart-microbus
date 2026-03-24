import 'package:dio/dio.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';

import 'error_response_model.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handle(DioException e) {
    try {
      if (e.response?.statusCode == 401 && TokenManager.token != null) {
        return const UnauthorizedFailure();
      }

      final data = e.response?.data;

      if (data != null && data is Map<String, dynamic>) {
        final errorModel = ErrorResponseModel.fromJson(data);

        String message = errorModel.message;

        if (errorModel.errors != null && errorModel.errors!.isNotEmpty) {
          message = errorModel.errors!.join('\n');
        }

        return ServerFailure(message);
      }

      return const ServerFailure("Server error occurred");
    } on DioException {
      return const NetworkFailure("No internet connection");
    } catch (_) {
      return const UnknownFailure("Unexpected error occurred");
    }
  }
}
