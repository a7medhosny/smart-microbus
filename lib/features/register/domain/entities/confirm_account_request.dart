class ConfirmAccountRequest{
   final String phoneNumber;
  final String otp;

  ConfirmAccountRequest({
    required this.phoneNumber,
    required this.otp,
  });
}