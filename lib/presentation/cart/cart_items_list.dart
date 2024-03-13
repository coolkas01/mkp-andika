import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/data/repository/cart_repository_impl.dart';
import 'package:mitra/data/source/local/cart_local_data.dart';
import 'package:mitra/domain/usecase/cart_usecase.dart';
import 'package:mitra/presentation/cart/bloc/cart_bloc.dart';
import 'package:mitra/presentation/cart/bloc/cart_event.dart';

import 'bloc/cart_state.dart';

class CartItemsListPage extends StatelessWidget {
  const CartItemsListPage({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (_) =>
            CartBloc(
              usecase: CartUsecase(
                CartRepositoryImpl(
                  CartLocalDataImpl(),
                ),
              ),
              userId: userId,
            ),
        child: const CartItemsListView(),
      );
}

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(GetCartItems());
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (_, state) {
          debugPrint(state.toString());
          if (state is CartLoading) {
            return const CircularProgressIndicator();
          }

          if (state is CartFailed) {
            return Text(state.error);
          }

          if (state is CartSuccess) {
            final items = state.items;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) =>
                    ListTile(
                      title: Text(items[index].productId.toString()),
                      subtitle: Text('Qty: ${items[index].quantity}'),
                    )
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}