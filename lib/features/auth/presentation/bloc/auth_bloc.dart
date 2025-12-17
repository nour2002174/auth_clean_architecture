import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domian/entities/user.dart';
import '../../domian/usecases/login_usecase.dart';
import '../../domian/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUsecase;
  final SignupUseCase signupUsecase;

  AuthBloc({required this.loginUsecase, required this.signupUsecase}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUsecase(event.email, event.password);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signupUsecase(event.name, event.email, event.password);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthInitial());
    });
  }
}
