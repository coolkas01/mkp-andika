import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/domain/repository/product_repository.dart';
import '../../../domain/usecase/cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.usecase, required this.repository}) : super(CartInitial()) {
    on<GetCartItems>(_getCartItems);
    on<AddItem>(_addItem);
    on<RemoveItem>(_remove);
  }

  final ProductRepository repository;
  final CartUsecase usecase;

  FutureOr<void> _getCartItems(GetCartItems event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final items = await usecase.getCartItems(userId: event.userId);
    if (items.isEmpty) {
      emit(CartFailed('Please add 1 or more item(s) to the cart'));
    } else {
      emit(CartSuccess(items));
    }
  }

  Future<void> _addItem(AddItem event, Emitter<CartState> emit) async {
    try {
      await usecase.addItemToCart(userId: event.userId, productId: event.productId, quantity: 1);
      final items = await usecase.getCartItems(userId: event.userId);
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailed(e.toString()));
    }
  }

  Future<void> _remove(RemoveItem event, Emitter<CartState> emit) async {
    try {
      await usecase.removeItem(userId: event.userId, productId: event.productId, quantity: 1);
      emit(CartLoading());
      final items = await usecase.getCartItems(userId: event.userId);
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailed(e.toString()));
    }
  }
}
