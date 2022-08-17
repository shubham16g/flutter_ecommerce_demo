
import 'package:ecom/floor/entities/cart_item.dart';
import 'package:floor/floor.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM CartItem')
  Stream<List<CartItem>> allItemsStream();

  @Query('SELECT * FROM CartItem')
  Future<List<CartItem>> getAllItems();

  @insert
  Future<void> insertCartItem(CartItem cartItem);

  @Query('SELECT * FROM CartItem WHERE id = :id')
  Future<CartItem?> getCartItem(int id);

  @update
  Future<void> updateCartItem(CartItem cartItem);

  Future<void> updateQuantity(int id, int quantity) async {
    final cartItem = await getCartItem(id);
    if (cartItem != null) {
      if (quantity == 0) {
        deleteCartItem(cartItem);
        return;
      }
      cartItem.quantity = quantity;
      await updateCartItem(cartItem);
    }
  }

  @delete
  Future<void> deleteCartItem(CartItem cartItem);

  Future<void> insertOrUpdate(CartItem cartItem) async {
    final existingCartItem = await getCartItem(cartItem.id);
    if (existingCartItem == null) {
      await insertCartItem(cartItem);
    } else {
      await updateCartItem(cartItem);
    }
  }

  static CartDao get nullInstance => _NullCartDao();
}

class _NullCartDao extends CartDao {

  Stream<List<CartItem>> _countStream() async* {
  }

  @override
  Stream<List<CartItem>> allItemsStream() {
    return _countStream();
  }

  @override
  Future<void> deleteCartItem(CartItem cartItem) {
    return Future.delayed(const Duration(milliseconds: 20));
  }

  @override
  Future<List<CartItem>> getAllItems() {
    return Future.delayed(const Duration(milliseconds: 20));
  }

  @override
  Future<CartItem?> getCartItem(int id) {
    return Future.delayed(const Duration(milliseconds: 20));
  }

  @override
  Future<void> insertCartItem(CartItem cartItem) {
    return Future.delayed(const Duration(milliseconds: 20));
  }

  @override
  Future<void> updateCartItem(CartItem cartItem) {
    return Future.delayed(const Duration(milliseconds: 20));

  }
}