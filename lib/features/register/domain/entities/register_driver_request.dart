class RegisterDriverRequest {
  final String displayName;
  final String phoneNumber;
  final String password;
  final String licenseNumber;

  RegisterDriverRequest({
    required this.displayName,
    required this.phoneNumber,
    required this.password,
    required this.licenseNumber,
  });
}
