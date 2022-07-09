import 'package:floor/floor.dart';

import '../../models/response/product_entity.dart';

@entity
class CartItem {
  @primaryKey
  final int id;
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.quantity});

  factory CartItem.fromProduct(ProductEntity product, int quantity) {
    return CartItem(
        id: product.id,
        title: product.title,
        image: product.image,
        price: product.price,
        quantity: quantity);
  }
}
