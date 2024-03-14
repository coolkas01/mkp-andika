sealed class AuthState {}

final class AuthStateUnknown extends AuthState {}

final class AuthenticatedState extends AuthState {}

final class UnauthenticatedState extends AuthState {}