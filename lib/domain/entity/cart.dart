import 'package:mitra/domain/entity/product.dart';

class Cart {
  final int userId;
  final List<(Product, int)> products;

  Cart({
    required this.userId,
    this.products = const [],
  });
}