import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<void> cacheUserToken(String token);
  Future<String?> getCachedUserToken();
  Future<void> clearUserToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String USER_KEY = 'CACHED_USER';
  static const String TOKEN_KEY = 'USER_TOKEN';

  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_KEY, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(USER_KEY);
    if (jsonString == null) return null;

    final data = jsonDecode(jsonString);
    return UserModel.fromJson(data);
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
