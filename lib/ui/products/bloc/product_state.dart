part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductsUpdated extends ProductState {
  final List<ProductEntity?> products;
  final String? error;
  ProductsUpdated(this.products, {this.error});
}

class ProductLoadError extends ProductState {

  final String error;
  ProductLoadError(this.error);
}
