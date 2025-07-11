class UserModel {
  final String username;
  final String email;
  final String password;

  const UserModel({
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'password': password};
  }
}
