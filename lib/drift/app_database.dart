
import 'package:drift/drift.dart';

import '../models/response/product_entity.dart';
part 'app_database.g.dart';


@DriftDatabase(tables: [CartItems],
    daos: [CartDao])
class AppDatabase extends _$AppDatabase {
  // AppDatabase(QueryExecutor e) : super()
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

class CartItems extends Table {

  IntColumn get id => integer().unique()();
  TextColumn get title => text().withLength(max: 255)();
  TextColumn get image => text().withLength(max: 255)();
  RealColumn get price => real()();
  IntColumn get quantity => integer()();


  @override
  Set<Column> get primaryKey => {id};

  static lol() => 'qlq';
}

@DriftAccessor(tables: [CartItems])
class CartDao extends DatabaseAccessor<AppDatabase> with _$CartDaoMixin {
  CartDao(AppDatabase db): super(db);

  // Future deleteAllSubCategory() => delete(cartItems).go();
  Stream<List<CartItem>> allItemsStream() => select(cartItems).watch();
  Future<List<CartItem>> getAllItems() => select(cartItems).get();

  Future<void> insertCartItem(CartItem cartItem) => into(cartItems).insert(cartItem);

  Future<CartItem?> getCartItem(int id) => (select(cartItems)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> updateCartItem(CartItem cartItem) => update(cartItems).replace(cartItem);

  Future<void> deleteCartItem(CartItem cartItem) => (delete(cartItems)..where((t) => t.id.equals(cartItem.id))).go();


  Future<void> updateQuantity(int id, int quantity) async {
    final cartItem = await getCartItem(id);
    if (cartItem != null) {
      if (quantity == 0) {
        deleteCartItem(cartItem);
        return;
      }
      await updateCartItem(cartItem.copyWith(quantity: quantity));
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

CartItem cartItemFromProduct(ProductEntity product, int quantity) {
    return CartItem(
        id: product.id,
        title: product.title,
        image: product.image,
        price: product.price,
        quantity: quantity);
}
