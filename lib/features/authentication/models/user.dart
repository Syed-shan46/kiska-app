import 'dart:convert';

class User {
  final String id;
  final String userName;
  final String email;
  final String password;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "userName": userName,
      "email": email,
      "password": password,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] as String? ?? "",
        userName: map['userName'] as String? ?? "",
        email: map['email'] as String? ?? "",
        password: map['password'] as String? ?? "");
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
