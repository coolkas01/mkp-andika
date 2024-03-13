import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/product_usecase.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key, required this.usecase});

  final ProductUsecase usecase;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductBloc(
            usecase: usecase,
          )..add(FetchAllProductsEvent()),
      child: const ProductListView(),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (_, state) {
        if (state is ProductLoading) {
          return const CircularProgressIndicator();
        }

        if (state is ProductFailed) {
          return Text(state.error);
        }

        if (state is ProductSuccess) {
          final products = state.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) =>
                ListTile(
                  leading: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.network(products[index].image ?? ''),
                  ),
                  title: Text(products[index].title, softWrap: false),
                  subtitle: Text(products[index].price.toString()),
                ),
          );
        }

        return const SizedBox();
      },
    );
  }
}


