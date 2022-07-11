import 'package:dio/dio.dart';
import 'package:ecom/di/service_locator.dart';
import 'package:ecom/floor/daos/cart_dao.dart';
import 'package:ecom/floor/db/app_database.dart';
import 'package:ecom/floor/entities/cart_item.dart';
import 'package:ecom/models/request/products_request.dart';
import 'package:ecom/models/response/product_entity.dart';

import '../models/response/products_response.dart';
import '../network/endpoints/products_endpoint.dart';

class CartRepository {
  final CartDao _cartDao;

  CartRepository(this._cartDao);

  Future<void> addToCart(ProductEntity product) async {
    final oldItem = await _cartDao.getCartItem(product.id);
    if (oldItem != null) {
      return _cartDao.updateCartItem(CartItem.fromProduct(product, oldItem.quantity + 1));
    } else {
      return _cartDao.insertCartItem(CartItem.fromProduct(product, 1));
    }
  }

  Future<void> updateCartQuantity(int id, int quantity) async {
    _cartDao.updateQuantity(id, quantity);
  }

  Stream<List<CartItem>> getAllCartItems() => _cartDao.getAllCartItems();
}
