import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/auth/bloc/auth_event.dart';

import '../../../data/repository/auth_repository_impl.dart';
import '../../../domain/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthStateUnknown()) {
    on<AuthStatusChanged>(_onAuthStateChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    _authSubscription = _authRepository.status.listen((status) {
      add(AuthStatusChanged(status));
    });
  }

  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus> _authSubscription;

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthStateChanged(AuthStatusChanged event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated: return emit(UnauthenticatedState());
      case AuthenticationStatus.authenticated: return emit(AuthenticatedState());
      case AuthenticationStatus.unknown: return emit(AuthStateUnknown());
    }
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) {
    _authRepository.login(username: event.username, password: event.password);
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    _authRepository.logout();
  }
}

