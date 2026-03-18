class VerifyOtpResponseEntity {
  final VerifyOtpDataEntity data;
  final bool success;
  final String message;

  VerifyOtpResponseEntity({
    required this.data,
    required this.success,
    required this.message,
  });
}

class VerifyOtpDataEntity {
  final String token;
  final String userId;

  VerifyOtpDataEntity({required this.token, required this.userId});
}
