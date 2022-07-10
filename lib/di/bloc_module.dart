import '../ui/products/bloc/product_cubit.dart';
import 'get_it_init.dart';


Future<void> registerBlocs() async {
  locator.registerFactory<ProductCubit>(() => ProductCubit(locator.get(), locator.get()));
}