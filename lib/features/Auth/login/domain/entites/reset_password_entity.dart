class ResetPasswordEntity {
  final String? userId;
  final String? token;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordEntity({
    required this.userId,
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });
}
