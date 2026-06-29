part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthRequest? loginRequest;
  final Failure? loginFailure;

  final AuthRequest? loginWithGoogleRequest;
  final Failure? loginWithGoogleFailure;

  final AuthRequest? registerRequest;
  final Failure? registerFailure;

  final AuthRequest? logoutRequest;
  final Failure? logoutFailure;

  final UserModel? userModel;

  const AuthState({
    this.loginRequest,
    this.loginFailure,
    this.loginWithGoogleRequest,
    this.loginWithGoogleFailure,
    this.logoutRequest,
    this.logoutFailure,
    this.registerRequest,
    this.registerFailure,
    this.userModel,
  });

  factory AuthState.initial() {
    return const AuthState(
      loginRequest: AuthRequest.initial,
      loginWithGoogleRequest: AuthRequest.initial,
      registerRequest: AuthRequest.initial,
      logoutRequest: AuthRequest.initial,
      loginFailure: null,
      loginWithGoogleFailure: null,
      registerFailure: null,
      logoutFailure: null,
      userModel: null,
    );
  }

  AuthState copyWith({
    AuthRequest? loginRequest,
    Failure? loginFailure,
    AuthRequest? loginWithGoogleRequest,
    Failure? loginWithGoogleFailure,
    AuthRequest? registerRequest,
    Failure? registerFailure,
    UserModel? userModel,
    AuthRequest? logoutRequest,
    Failure? logoutFailure,
  }) {
    return AuthState(
      loginRequest: loginRequest ?? this.loginRequest,
      loginFailure: loginFailure ?? this.loginFailure,
      loginWithGoogleRequest:
          loginWithGoogleRequest ?? this.loginWithGoogleRequest,
      loginWithGoogleFailure:
          loginWithGoogleFailure ?? this.loginWithGoogleFailure,
      logoutRequest: loginRequest ?? this.logoutRequest,
      logoutFailure: loginFailure ?? this.logoutFailure,
      registerRequest: registerRequest ?? this.registerRequest,
      registerFailure: registerFailure ?? this.registerFailure,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [
    loginRequest,
    loginFailure,
    loginWithGoogleRequest,
    loginWithGoogleFailure,
    registerRequest,
    registerFailure,
    userModel,
  ];
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

enum AuthRequest { initial, loading, success, error }
