import 'package:mitra/domain/entity/cart.dart';
import 'package:mitra/domain/repository/cart_repository.dart';

class CartUsecase implements CartRepository {
  final CartRepository _repository;

  CartUsecase(this._repository);

  @override
  Future<List<Cart>> getCartItems({required int userId}) =>
      _repository.getCartItems(userId: userId);

}