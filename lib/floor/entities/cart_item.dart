import 'package:floor/floor.dart';

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
}
