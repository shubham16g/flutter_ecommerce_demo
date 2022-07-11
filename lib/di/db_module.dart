import 'package:ecom/ui/cart/bloc/cart_cubit.dart';

import '../floor/db/app_database.dart';
import '../ui/products/bloc/product_cubit.dart';
import 'service_locator.dart';


Future<void> registerDatabase() async {
  final db = await AppDatabase.instance;
  locator.registerLazySingleton<AppDatabase>(() => db);
  // locator.registerSingleton<AppDatabase>(db);
  //dao
  locator.registerLazySingleton(() => locator.get<AppDatabase>().cartDao);
}