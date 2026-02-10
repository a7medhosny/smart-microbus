class UserEntity {
  final String userName;
  final String phoneNumber;
  final String token;
  final String refreshToken;
  final String tokenExpiration;
  final String refreshTokenExpiration;

  const UserEntity({
    required this.userName,
    required this.phoneNumber,
    required this.token,
    required this.refreshToken,
    required this.tokenExpiration,
    required this.refreshTokenExpiration,
  });
}
