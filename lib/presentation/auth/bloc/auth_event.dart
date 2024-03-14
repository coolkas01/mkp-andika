import 'package:mitra/data/repository/auth_repository_impl.dart';

sealed class AuthEvent {}

class AuthStatusChanged extends AuthEvent {
  AuthStatusChanged(this.status);

  final AuthenticationStatus status;
}

class LoginSubmitted extends AuthEvent {
  LoginSubmitted({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class LogoutRequested extends AuthEvent {}