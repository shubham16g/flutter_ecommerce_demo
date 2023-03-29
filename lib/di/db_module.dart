import 'package:ecom/drift/app_database.dart';
import 'package:ecom/drift/config/shared.dart';
import 'service_locator.dart';

Future<void> registerDatabase() async {
  // locator.registerSingleton<AppDatabase>(db);
  //dao
  final db = constructDb();
  locator.registerLazySingleton<AppDatabase>(() => db);
  locator.registerLazySingleton(() => locator.get<AppDatabase>().cartDao);
}
