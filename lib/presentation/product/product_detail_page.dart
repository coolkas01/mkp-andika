import 'package:flutter/material.dart';

import '../../domain/entity/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(),
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
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      );
}
