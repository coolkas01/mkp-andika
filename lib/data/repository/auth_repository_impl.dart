import 'dart:async';

import 'package:mitra/domain/repository/auth_repository.dart';

import '../source/network/fake_store_user_auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api);

  final FSUserAuthApi _api;
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<String> login({required String username, required String password}) async {
    final token = await _api.login(username: username, password: password);
    _controller.add(AuthenticationStatus.authenticated);
    return token;
  }

  @override
  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }