import 'package:ecom/floor/daos/cart_dao.dart';
import 'package:flutter/foundation.dart';
import '../floor/db/app_database.dart';
import 'service_locator.dart';


Future<void> registerDatabase() async {
  // locator.registerSingleton<AppDatabase>(db);
  //dao
  if(kIsWeb) {
    locator.registerSingleton<CartDao>(CartDao.nullInstance);
  } else {
    final db = await AppDatabase.instance;
    locator.registerLazySingleton<AppDatabase>(() => db);
    locator.registerLazySingleton(() => locator.get<AppDatabase>().cartDao);
  }
}