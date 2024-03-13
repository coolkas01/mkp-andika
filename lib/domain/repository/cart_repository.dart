import '../entity/cart.dart';

abstract class CartRepository {
  Future<List<Cart>> getCartItems({required int userId});
}