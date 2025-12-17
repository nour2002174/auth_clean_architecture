// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:auth_clean_architecture/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signUp(String name, String email, String password);
  Future<void> logout();
}