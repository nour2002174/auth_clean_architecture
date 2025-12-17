import 'package:auth_clean_architecture/features/auth/domian/entities/user.dart';
class UserModel extends User {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  final String password; 
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  }) : super(id: id, name: name, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
