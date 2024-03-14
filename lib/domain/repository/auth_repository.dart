import 'package:mitra/data/repository/auth_repository_impl.dart';

abstract class AuthRepository {
  Stream<AuthenticationStatus> get status;
  Future<String> login({required String username, required String password});
  void logout();
  void dispose();
}
