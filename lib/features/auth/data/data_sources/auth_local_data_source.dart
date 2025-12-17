// lib/features/auth/data/data_sources/auth_local_data_source.dart
import 'package:auth_clean_architecture/features/auth/domian/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> clearUser();
  Future<void> cacheUserToken(String token);
  Future<String?> getCachedUserToken();
  Future<void> clearUserToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String USER_KEY = 'CACHED_USER';
  static const String TOKEN_KEY = 'USER_TOKEN';

  @override
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_KEY, jsonEncode({
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'password': user.password,
    }));
    print('User saved locally');
  }

  @override
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(USER_KEY);
    if (jsonString == null) return null;
    final data = jsonDecode(jsonString);
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
    );
  }

  @override
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_KEY);
  }

  @override
  Future<void> cacheUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN_KEY, token);
  }

  @override
  Future<String?> getCachedUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  @override
  Future<void> clearUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN_KEY);
  }
}
