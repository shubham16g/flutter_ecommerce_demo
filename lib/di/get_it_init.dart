
import 'package:dio/dio.dart';
import 'package:ecom/di/endpoint_module.dart';
import 'package:ecom/di/repository_module.dart';
import 'package:ecom/floor/db/app_database.dart';
import 'package:ecom/network/dio_client.dart';
import 'package:get_it/get_it.dart';

import '../env/env.dart';
import 'bloc_module.dart';

final locator = GetIt.instance;

Future<bool?> getItInit(Env env) async {
  _setupDefaultDio(env.baseUrl, env.token);
  _databaseInit();
  await registerEndPoints();
  await registerRepositories();
  await registerBlocs();
  print('openning ');
  return null;
}

Future<void> _databaseInit() async {
  final db = await AppDatabase.instance;
  locator.registerLazySingleton<AppDatabase>(
          () => db);
  locator.registerLazySingleton(() => locator.get<AppDatabase>().cartDao);
}

void _setupDefaultDio(String baseUrl, String token) {
  locator.registerLazySingleton<Dio>(
          () => DioClient.build(baseUrl, token));
}
