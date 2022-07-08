part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity?> products;

  ProductLoaded(this.products);
}

class ProductLoadError extends ProductState {
  final List<ProductEntity?> products;

  ProductLoadError(this.products);
}
