class UserEntity {
  final String userName;
  final String phone;
  final String token;
  final String expiration;
  final String refreshToken;
  final String refreshTokenExpirationDateTime;
  final bool? success;
  final String? message;
  final int? statusCode;

  UserEntity({
    required this.userName,
    required this.phone,
    required this.token,
    required this.expiration,
    required this.refreshToken,
    required this.refreshTokenExpirationDateTime,
    this.success,
    this.message,
    this.statusCode,
  });
}
