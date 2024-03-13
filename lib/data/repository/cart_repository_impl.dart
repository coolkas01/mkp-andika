import 'package:mitra/domain/entity/cart.dart';
import 'package:mitra/domain/repository/cart_repository.dart';

import '../source/local/cart_local_data.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalData _cache;

  CartRepositoryImpl(this._cache);

  @override
  Future<List<Cart>> getCartItems({required int userId}) =>
      _cache.getCartItems(userId: userId);

}