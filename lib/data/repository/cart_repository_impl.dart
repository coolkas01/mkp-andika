import 'package:mitra/data/repository/product_repository_impl.dart';
import 'package:mitra/data/source/network/fake_store_product_api.dart';
import 'package:mitra/domain/entity/cart.dart';
import 'package:mitra/domain/entity/product.dart';
import 'package:mitra/domain/repository/cart_repository.dart';

import '../source/local/cart_local_data.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalData _cache;

  CartRepositoryImpl(this._cache);

  @override
  Future<List<(Cart, Product)>> getCartItems({required int userId}) async {
    final products = await ProductRepositoryImpl(api: FSProductApiImpl()).fetchAllProducts();
    final cartItems = await _cache.getCartItems(userId: userId);
    return cartItems.map((item) => (item, products.firstWhere((product) => product.id == item.productId))).toList();
    // return _cache.getCartItems(userId: userId);
  }

  @override
  Future<void> addItemToCart({required int userId, required int productId, required int quantity}) =>
      _cache.addItemToCart(userId: userId, productId: productId, quantity: quantity);

  @override
  removeItem({required int userId, required int productId, required int quantity}) =>
      _cache.removeItem(userId: userId, productId: productId, quantity: quantity);
}