import 'package:auth_clean_architecture/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/data_sources/auth_remote_datasource.dart';
import 'features/auth/data/repoistries_data/auth_repository_impl.dart';
import 'features/auth/domian/usecases/login_usecase.dart';
import 'features/auth/domian/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  //final remoteDataSource = AuthRemoteDataSourceImpl();
  final localDataSource = AuthLocalDataSourceImpl();

  final authRepository = AuthRepositoryImpl(
    //remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  final loginUsecase = LoginUseCase(authRepository: authRepository);
  final signupUsecase = SignupUseCase(authRepository:authRepository);
  runApp(
    BlocProvider(
      create: (_) => AuthBloc(
        loginUsecase: loginUsecase,
        signupUsecase: signupUsecase,
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
