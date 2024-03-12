import 'package:mitra/domain/entity/product.dart';
import 'package:mitra/domain/repository/product_repository.dart';

class ProductUsecase implements ProductRepository {
  final ProductRepository repository;

  ProductUsecase({required this.repository});

  @override
  Future<List<Product>> fetchAllProducts() {
    return repository.fetchAllProducts();
  }
}