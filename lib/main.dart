import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mitra/data/repository/product_repository_impl.dart';
import 'package:mitra/data/source/network/fake_store_api.dart';
import 'package:mitra/domain/usecase/product_usecase.dart';
import 'package:mitra/presentation/product/product_list_page.dart';
import 'package:path_provider/path_provider.dart';

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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
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
        actions: const [
          Icon(Icons.shopping_cart),
          SizedBox(width: 8.0),
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
    );
  }
}
