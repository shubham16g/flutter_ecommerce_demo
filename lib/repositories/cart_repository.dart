import 'package:ecom/drift/app_database.dart';
import 'package:ecom/models/response/product_entity.dart';

class CartRepository {
  final CartDao _cartDao;

  CartRepository(this._cartDao);

  Future<void> addToCart(ProductEntity product) async {
    final oldItem = await _cartDao.getCartItem(product.id);
    if (oldItem != null) {
      return _cartDao
          .updateCartItem(cartItemFromProduct(product, oldItem.quantity + 1));
    } else {
      return _cartDao.insertCartItem(cartItemFromProduct(product, 1));
    }
  }

  Future<void> updateCartQuantity(int id, int quantity) async {
    _cartDao.updateQuantity(id, quantity);
  }

  Stream<List<CartItem>> allItemsStream() => _cartDao.allItemsStream();
  Future<List<CartItem>> getAllItems() => _cartDao.getAllItems();
}
