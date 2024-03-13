import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/domain/usecase/product_usecase.dart';
import 'package:mitra/presentation/product/bloc/product_event.dart';
import 'package:mitra/presentation/product/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.usecase}) : super(ProductInitial()) {
    on<FetchAllProductsEvent>(_fetchAllProducts);
  }

  final ProductUsecase usecase;

  FutureOr<void> _fetchAllProducts(ProductEvent event, Emitter<ProductState> emit) async {
    if (event is! FetchAllProductsEvent) {
      return;
    }

    emit(ProductLoading());
    final products = await usecase.fetchAllProducts();
    if (products.isEmpty) {
      emit(ProductFailed('Nothing to show in here...'));
    } else {
      emit(ProductSuccess(products));
    }
  }
}