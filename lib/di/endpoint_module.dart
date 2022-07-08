import 'package:ecom/network/endpoints/products_endpoint.dart';

import '../ui/products/bloc/product_cubit.dart';
import 'get_it_init.dart';


Future<void> registerEndPoints() async {
  locator.registerFactory<ProductsEndpoint>(() => ProductsEndpoint(locator.get()));
}