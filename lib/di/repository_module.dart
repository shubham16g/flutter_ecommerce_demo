

import 'package:ecom/repositories/cart_repository.dart';
import 'package:ecom/repositories/products_repository.dart';

import 'get_it_init.dart';

Future<void> registerRepositories() async {
  locator.registerFactory<ProductsRepository>(() => ProductsRepository(locator.get()));
  locator.registerFactory<CartRepository>(() => CartRepository());
}