import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);

  Future<UserModel> signUp(String name, String email, String password);
}
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (email == 'nour@test.com' && password == '123456') {
      return UserModel(id: '1', name: 'Nour', email: email, password: '');
    } else {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return UserModel(id: '2', name: name, email: email, password: '');
  }
}