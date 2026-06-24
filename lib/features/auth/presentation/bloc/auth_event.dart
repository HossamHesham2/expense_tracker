part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;

  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogleEvent extends AuthEvent {
  const LoginWithGoogleEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final String email;

  final String password;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}

class LogOutEvent extends AuthEvent {
  const LogOutEvent();

  @override
  List<Object?> get props => [];
}
