
import 'package:ecom/floor/entities/cart_item.dart';
import 'package:floor/floor.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM CartItem')
  Stream<List<CartItem>> getAllCartItems();

  @insert
  Future<void> insertCartItem(CartItem cartItem);

  @Query('SELECT * FROM CartItem WHERE id = :id')
  Future<CartItem?> getCartItem(int id);

  @update
  Future<void> updateCartItem(CartItem cartItem);

  Future<void> updateQuantity(int id, int quantity) async {
    final cartItem = await getCartItem(id);
    if (cartItem != null) {
      cartItem.quantity = quantity;
      await updateCartItem(cartItem);
    }
  }

  Future<void> insertOrUpdate(CartItem cartItem) async {
    final existingCartItem = await getCartItem(cartItem.id);
    if (existingCartItem == null) {
      await insertCartItem(cartItem);
    } else {
      await updateCartItem(cartItem);
    }
  }
}