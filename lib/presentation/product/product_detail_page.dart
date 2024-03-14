import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/cart/bloc/cart_bloc.dart';
import 'package:mitra/presentation/cart/bloc/cart_event.dart';

import '../../domain/entity/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text(product.category ?? ''),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(product.image ?? ''),
                ),
                Text(product.price.toString(), style: Theme.of(context).textTheme.titleLarge),
                Text(product.title, style: Theme.of(context).textTheme.titleMedium),
                Text(product.description ?? ''),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<CartBloc>().add(AddItem(1, product.id));
          },
          child: const Icon(Icons.add),
        ),
      );
}
