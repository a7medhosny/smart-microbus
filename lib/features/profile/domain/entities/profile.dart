class Profile {
  final String id;
  final String name;
  final String phone;
  final String role;
  final bool isActive;
  final String? photoUrl;

  Profile({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.isActive,
    this.photoUrl,
  });

  Profile copyWith({
    String? id,
    String? name,
    String? phone,
    String? role,
    bool? isActive,
    String? photoUrl,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      photoUrl: photoUrl, // 🔥 مهم
    );
  }
}
