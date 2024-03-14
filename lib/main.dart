import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:mitra/data/repository/auth_repository_impl.dart';
import 'package:mitra/data/repository/product_repository_impl.dart';
import 'package:mitra/data/source/local/cart_local_data.dart';
import 'package:mitra/data/source/network/fake_store_product_api.dart';
import 'package:mitra/data/source/network/fake_store_user_auth_api.dart';
import 'package:mitra/domain/repository/auth_repository.dart';
import 'package:mitra/presentation/auth/bloc/auth_bloc.dart';
import 'package:mitra/presentation/auth/bloc/auth_state.dart';
import 'package:mitra/presentation/cart/bloc/cart_bloc.dart';
import 'package:mitra/presentation/product/product_list_page.dart';
import 'package:path_provider/path_provider.dart';
import 'data/repository/cart_repository_impl.dart';
import 'domain/entity/cart.dart';
import 'domain/usecase/cart_usecase.dart';

/// [Soal Front End Mobile]
// Buatlah aplikasi mobile menggunakan api fake store api https://fakestoreapi.com/docs.
// Ketentuan :
// 1. Terdapat halaman login (https://fakestoreapi.com/auth/login)
// 2. Terdapat halaman home (list product)  (https://fakestoreapi.com/products)
// 3. Terdapat halaman product detail (https://fakestoreapi.com/products/1)
// 4. Terdapat fitur add to cart (Simpan di local, karena api fakestore tidak bisa beneran add to cart)
// 5. Terdapat halaman checkout
// 6. Menggunakan state management BLoC
// 7. Menerapkan konsep clean architecture
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepositoryImpl(FSUserAuthApiImpl());
  }

  @override
  void dispose() {
    super.dispose();
    _authRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
        BlocProvider(
          create: (_) =>
              AuthBloc(
                authRepository: _authRepository,
              ),
        ),
        BlocProvider(
          create: (_) =>
              CartBloc(
                usecase: CartUsecase(
                  CartRepositoryImpl(
                    CartLocalDataImpl(),
                  ),
                ),
                repository: ProductRepositoryImpl(
                  api: FSProductApiImpl(),
                ),
              ),
        ),
      ],
      child: const AppView()
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Andika',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      builder: (ctx, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (_, state) {
            // if (state is AuthenticatedState) {
              _navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) =>
                  const ProductListPage(),
                ), (route) => false,
              );
            // }

            // if (state is UnauthenticatedState) {
            //   _navigator.pushAndRemoveUntil(
            //     MaterialPageRoute(
            //       builder: (ctx) =>
            //       const LoginPage(),
            //     ), (route) => false,
            //   );
            // }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) =>
          MaterialPageRoute(
            builder: (_) =>
            const SplashPage(),
          ),
      // home: const LoginPage(),
    );
  }
}


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
