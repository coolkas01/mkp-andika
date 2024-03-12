import '../../data/source/network/fake_store_api.dart';
import '../../domain/repository/product_repository.dart';
import '../../domain/entity/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FakeStoreApi api;

  ProductRepositoryImpl({
    required this.api,
  });

  @override
  Future<List<Product>> fetchAllProducts() =>
      api.fetchAllProducts();
}