import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.usecase, required this.userId}) : super(CartInitial()) {
    on<GetCartItems>(_getCartItems);
  }

  final CartUsecase usecase;
  final int userId;

  FutureOr<void> _getCartItems(CartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final items = await usecase.getCartItems(userId: userId);
    if (items.isEmpty) {
      emit(CartFailed('Please add 1 or more item(s) to the cart'));
    } else {
      emit(CartSuccess(items));
    }
  }
}
