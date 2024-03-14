import '../../data/source/network/fake_store_product_api.dart';
import '../../domain/repository/product_repository.dart';
import '../../domain/entity/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FSProductApi api;

  ProductRepositoryImpl({
    required this.api,
  });

  @override
  Future<List<Product>> fetchAllProducts() =>
      api.fetchAllProducts();
}