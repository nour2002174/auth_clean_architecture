// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:auth_clean_architecture/core/errors/failures.dart';
import 'package:auth_clean_architecture/features/auth/domian/entities/user.dart';
import 'package:auth_clean_architecture/features/auth/domian/repositries/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});
@override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await localDataSource.getUser();
      if (user == null) return Left(ValidationFailure('No user found. Please signup first!'));
      if (user.email != email || user.password != password) {
        return Left(ValidationFailure('Invalid email or password'));
      }
      await localDataSource.cacheUserToken(user.id);
      return Right(user); 
    } catch (e) {
      return Left(CacheFailure('Failed to access local storage'));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(String name, String email, String password) async {
    try {
      final existingUser = await localDataSource.getUser();
      if (existingUser != null && existingUser.email == email) {
        return Left(ValidationFailure('Email already exists'));
      }
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
      );
      await localDataSource.saveUser(newUser);
      await localDataSource.cacheUserToken(newUser.id);
      return Right(newUser); 
    } catch (e) {
      return Left(CacheFailure('Failed to save user'));
    }
  }
 

  @override
  Future<void> logout() async {
    await localDataSource.clearUserToken();
    await localDataSource.clearUser();
    print('User logged out');
  }
}
