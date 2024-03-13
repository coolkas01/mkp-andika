import '../../../../domain/entity/product.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess(this.products);
}

final class ProductFailed extends ProductState {
  final String error;

  ProductFailed(this.error);
}