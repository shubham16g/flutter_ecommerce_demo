part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  CartLoaded(this.cartItems);
}

class ProductLoadError extends CartState {
  final List<ProductEntity?> products;

  ProductLoadError(this.products);
}
