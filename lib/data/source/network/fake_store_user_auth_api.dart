import 'dart:convert';
import 'package:http/http.dart';

abstract class FSUserAuthApi {
  Future<String> login({required String username, required String password});
}

class FSUserAuthApiImpl implements FSUserAuthApi {
  final client = Client();

  @override
  Future<String> login({
    required String username,
    required String password}) async {
    try {
      final response = await client.post(Uri.parse('https://fakestoreapi.com/auth/login'), body: {
        'username': username,
        'password': password,
      });
      if (response.statusCode != 200) {
        throw Exception('Authentication failed');
      }

      final result = json.decode(response.body);
      return result['token'];
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<User> getUser({required int userId}) async {
  //   try {
  //     final response = await client.get(Uri.parse('https://fakestoreapi.com/users/$userId'));
  //     if (response.statusCode != 200) {
  //       throw Exception('User not found');
  //     }
  //
  //     return UserDto.fromJson(json.decode(response.body));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}