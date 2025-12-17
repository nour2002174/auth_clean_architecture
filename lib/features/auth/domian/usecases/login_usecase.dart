import 'package:auth_clean_architecture/core/errors/failures.dart';
import 'package:auth_clean_architecture/features/auth/domian/repositries/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository}); 

  Future<Either<Failure, User>> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
