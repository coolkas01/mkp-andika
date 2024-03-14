import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/cart/bloc/cart_bloc.dart';
import 'package:mitra/presentation/cart/bloc/cart_event.dart';
import 'package:mitra/presentation/checkout/checkout_item_page.dart';
import 'bloc/cart_state.dart';

class CartItemsListPage extends StatelessWidget {
  const CartItemsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (_, state) {
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
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Image.network(items[index].$2.image!, width: 50),
                            Expanded(
                              child: ListTile(
                                title: Text(items[index].$2.title, softWrap: false),
                                subtitle: Text('Qty: ${items[index].$1.quantity}, Price: ${items[index].$2.price}'),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<CartBloc>().add(RemoveItem(1, items[index].$1.productId));
                              },
                              icon: const Icon(Icons.arrow_downward),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<CartBloc>().add(AddItem(1, items[index].$1.productId));
                              },
                              icon: const Icon(Icons.arrow_upward),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => CheckoutItemPage(product: items[index].$2, quantity: items[index].$1.quantity),
                                  )
                                );
                              },
                              icon: const Icon(Icons.shopping_cart_checkout),
                            ),
                          ],
                        ),
                      ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
