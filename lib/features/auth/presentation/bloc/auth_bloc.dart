import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case LoginEvent():
          emit(state.copyWith(loginRequest: AuthRequest.loading));
          final result = await authRepo.login(
            email: event.email,
            password: event.password,
          );
          result.fold(
            (l) => emit(
              state.copyWith(
                loginFailure: ServerFailure(l.message),
                loginRequest: AuthRequest.error,
              ),
            ),
            (r) => emit(
              state.copyWith(loginRequest: AuthRequest.success, userModel: r),
            ),
          );
          break;

        case LoginWithGoogleEvent():
          emit(state.copyWith(loginWithGoogleRequest: AuthRequest.loading));
          final result = await authRepo.loginWithGoogle();
          result.fold(
            (l) => emit(
              state.copyWith(
                loginWithGoogleFailure: ServerFailure(l.message),
                loginWithGoogleRequest: AuthRequest.error,
              ),
            ),
            (r) => emit(
              state.copyWith(
                loginWithGoogleRequest: AuthRequest.success,
                userModel: r,
              ),
            ),
          );
          break;

        case RegisterEvent():
          emit(state.copyWith(registerRequest: AuthRequest.loading));
          final result = await authRepo.register(
            fullName: event.fullName,
            email: event.email,
            password: event.password,
          );
          result.fold(
            (l) => emit(
              state.copyWith(
                registerFailure: ServerFailure(l.message),
                registerRequest: AuthRequest.error,
              ),
            ),
            (r) => emit(
              state.copyWith(
                registerRequest: AuthRequest.success,
                userModel: r,
              ),
            ),
          );
          break;
        case LogOutEvent():
          emit(AuthState.initial());
          break;
      }
    });
  }
}
