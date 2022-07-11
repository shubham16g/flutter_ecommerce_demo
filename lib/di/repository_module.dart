

import 'package:ecom/repositories/cart_repository.dart';
import 'package:ecom/repositories/products_repository.dart';

import 'service_locator.dart';

Future<void> registerRepositories() async {
  locator.registerFactory(() => ProductsRepository(locator()));
  locator.registerFactory(() => CartRepository(locator()));
}