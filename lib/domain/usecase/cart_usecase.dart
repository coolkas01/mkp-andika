import 'package:mitra/domain/entity/cart.dart';
import 'package:mitra/domain/repository/cart_repository.dart';
import '../entity/product.dart';

class CartUsecase implements CartRepository {
  CartUsecase(this._repository);

  final CartRepository _repository;

  @override
  Future<List<(Cart, Product)>> getCartItems({required int userId}) =>
      _repository.getCartItems(userId: userId);

  @override
  Future<void> addItemToCart({required int userId, required int productId, required int quantity}) =>
      _repository.addItemToCart(userId: userId, productId: productId, quantity: quantity);

  @override
  Future<void> removeItem({required int userId, required int productId, required int quantity}) =>
      _repository.removeItem(userId: userId, productId: productId, quantity: quantity);

}