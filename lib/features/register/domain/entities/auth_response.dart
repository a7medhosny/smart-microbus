class AuthResponse {
  final bool success;
  final String message;
  final int statusCode;
  final String? userName;
  final String? token;
  final String? expiration;
  final String? refreshToken;
  final String? refreshTokenExpirationDateTime;

  AuthResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.userName,
    this.token,
    this.expiration,
    this.refreshToken,
    this.refreshTokenExpirationDateTime,
  });
}
