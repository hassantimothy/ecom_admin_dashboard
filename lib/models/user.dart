// lib/models/user.dart

class User {
  final String id;
  final String fullName;
  final String? profileImageUrl;
  final String email;
  final String role;

  User({
    required this.id,
    required this.fullName,
    this.profileImageUrl,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      profileImageUrl: json['profileImageUrl'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'role': role,
    };
  }
}
