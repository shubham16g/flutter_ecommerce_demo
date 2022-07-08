

import 'package:ecom/repositories/products_repository.dart';

import 'get_it_init.dart';

Future<void> registerRepositories() async {
  locator.registerFactory<ProductsRepository>(() => ProductsRepository(locator.get()));
}