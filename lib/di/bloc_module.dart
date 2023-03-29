import 'package:ecom/ui/cart/bloc/cart_cubit.dart';

import '../ui/products/bloc/product_cubit.dart';
import 'service_locator.dart';

Future<void> registerBlocs() async {
  locator.registerFactory(() => ProductCubit(locator(), locator()));
  locator.registerFactory(() => CartCubit(locator()));
}
