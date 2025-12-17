import 'package:auth_clean_architecture/core/errors/failures.dart';
import 'package:auth_clean_architecture/features/auth/domian/entities/user.dart';
import 'package:auth_clean_architecture/features/auth/domian/repositries/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/auth_local_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await localDataSource.getUser();

      if (userModel == null) {
        return Left(ValidationFailure('No user found. Please signup first!'));
      }

      if (userModel.email != email || userModel.password != password) {
        return Left(ValidationFailure('Invalid email or password'));
      }

      await localDataSource.cacheUserToken(userModel.id);
      return Right(userModel); // UserModel extends User
    } catch (e) {
      return Left(CacheFailure('Failed to access local storage'));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(
      String name, String email, String password) async {
    try {
      final existingUser = await localDataSource.getUser();
      if (existingUser != null && existingUser.email == email) {
        return Left(ValidationFailure('Email already exists'));
      }

      final userModel = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
      );

      await localDataSource.saveUser(userModel);
      await localDataSource.cacheUserToken(userModel.id);

      return Right(userModel);
    } catch (e) {
      return Left(CacheFailure('Failed to save user'));
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUserToken();
    await localDataSource.clearUser();
  }
}
