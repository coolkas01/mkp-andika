import '../../../domain/entity/cart.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<Cart> items;

  CartSuccess(this.items);
}

final class CartFailed extends CartState {
  final String error;

  CartFailed(this.error);
}