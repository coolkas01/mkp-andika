import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:mitra/data/dto/product_dto.dart';

abstract class FakeStoreApi {
  Future<List<ProductDto>> fetchAllProducts();
}

class FakeStoreApiImpl implements FakeStoreApi {
  final client = Client();

  @override
  Future<List<ProductDto>> fetchAllProducts() async {
    try {
      final response = await client.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode != 200) {
        throw Exception('Error when trying to load product(s)');
      }

      final result = json.decode(response.body);
      return List.from(result.map((e) => ProductDto.fromJson(e)));
    } catch (e) {
      rethrow;
    }
  }
}