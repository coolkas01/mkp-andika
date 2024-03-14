import '../entity/user.dart';

abstract class UserRepository {
  Future<User> fetchUserById();
}