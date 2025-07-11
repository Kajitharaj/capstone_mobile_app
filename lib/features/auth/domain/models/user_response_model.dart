import 'package:capstone_mobile_app/features/auth/domain/models/user_model.dart';

class UserResponseModel extends UserModel {
  final String token;
  final DateTime expiryAt;
  UserResponseModel({
    required this.token,
    required this.expiryAt,
    required super.username,
    required super.email,
    required super.password,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password:
          '', // Password usually won't come from API, so keep empty or null
      token: json['token'] as String,
      expiryAt: DateTime.parse(_parseExpiryAt(json['expiryAt'] as String)),
    );
  }

  static String _parseExpiryAt(String expiryStr) {
    return DateTime.now().toIso8601String();
  }
}
