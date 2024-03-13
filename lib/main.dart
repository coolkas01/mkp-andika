import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mitra/data/repository/product_repository_impl.dart';
import 'package:mitra/data/source/local/cart_local_data.dart';
import 'package:mitra/data/source/network/fake_store_api.dart';
import 'package:mitra/domain/usecase/product_usecase.dart';
import 'package:mitra/presentation/cart/cart_items_list.dart';
import 'package:mitra/presentation/product/product_list_page.dart';
import 'package:path_provider/path_provider.dart';
import 'domain/entity/cart.dart';

/// [Soal Front End Mobile]
// Buatlah aplikasi mobile menggunakan api fake store api https://fakestoreapi.com/docs.
// Ketentuan :
// 1. Terdapat halaman login (https://fakestoreapi.com/auth/login)
// 2. Terdapat halaman home (list product)  (https://fakestoreapi.com/products)
// 3. Terdapat halaman product detail (https://fakestoreapi.com/products/1)
// 4.Terdapat fiture add to cart (Simpan di local, karena api fakestore tidak bisa beneran add to cart)
// 5. Terdapat halaman checkout
// 6. Menggunakan state management BLoC
// 7. Menerapkan konsep clean architecture
///

void load() async {
  final dir = await getApplicationDocumentsDirectory();
  Isar.open([CartSchema], directory: dir.path);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andika',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Product(s)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      const CartItemsListPage(userId: 1),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          // SizedBox(width: 8.0),
        ],
      ),
      body: Center(
        child: ProductListPage(
          usecase: ProductUsecase(
            repository: ProductRepositoryImpl(
              api: FakeStoreApiImpl(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final items = await CartLocalDataImpl().getCartItems(userId: 1);
          for (final item in items) {
            debugPrint('cart: ${item.productId}, ${item.quantity}');
          }

          CartLocalDataImpl().addItemToCart(userId: 1, productId: 1, quantity: 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
