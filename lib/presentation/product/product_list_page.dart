import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/auth/bloc/auth_event.dart';
import 'package:mitra/presentation/product/product_detail_page.dart';

import '../../data/repository/product_repository_impl.dart';
import '../../data/source/network/fake_store_product_api.dart';
import '../../domain/usecase/product_usecase.dart';
import '../auth/bloc/auth_bloc.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../cart/cart_items_list.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductBloc(
            usecase: ProductUsecase(
              repository: ProductRepositoryImpl(
                api: FSProductApiImpl(),
              ),
            ),
          )..add(FetchAllProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text('Product(s)'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<CartBloc>().add(GetCartItems(1));

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                    const CartItemsListPage(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());

              },
              icon: const Icon(Icons.logout),
            ),
            // SizedBox(width: 8.0),
          ],
        ),
        body: const Center(
          child: ProductListView(),
        ),
      )
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
                  onTap: () =>
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailPage(product: products[index]),
                        ),
                      ),
                ),
          );
        }

        return const SizedBox();
      },
    );
  }
}


