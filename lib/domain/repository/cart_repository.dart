import '../entity/cart.dart';
import '../entity/product.dart';

abstract class CartRepository {
  Future<List<(Cart, Product)>> getCartItems({required int userId});
  addItemToCart({
    required int userId,
    required int productId,
    required int quantity,
  });
  removeItem({
    required int userId,
    required int productId,
    required int quantity,
  });
}