import 'package:mitra/data/repository/auth_repository_impl.dart';
import 'package:mitra/domain/repository/auth_repository.dart';

class AuthUsecase implements AuthRepository {
  AuthUsecase(this._repository);

  final AuthRepository _repository;

  @override
  Stream<AuthenticationStatus> get status => _repository.status;

  @override
  Future<String> login({required String username, required String password}) =>
      _repository.login(username: username, password: password);

  @override
  void logout() {
    _repository.logout();
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}