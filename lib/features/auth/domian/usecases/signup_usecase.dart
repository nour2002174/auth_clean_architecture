import 'package:auth_clean_architecture/core/errors/failures.dart';
import 'package:auth_clean_architecture/features/auth/data/repoistries_data/auth_repository_impl.dart';
import 'package:auth_clean_architecture/features/auth/domian/repositries/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

class SignupUseCase {
  final AuthRepository authRepository;

  SignupUseCase({required this.authRepository}); 

  Future<Either<Failure, User>> call(String name, String email, String password) {
    return authRepository.signUp(name, email, password);
  }
}
