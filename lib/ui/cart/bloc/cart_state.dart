part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  double get totalPrice => cartItems.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
  int get totalItems => cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

  CartLoaded(this.cartItems);
}

class CartEmpty extends CartState {}
