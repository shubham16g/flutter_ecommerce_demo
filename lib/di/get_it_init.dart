
import 'package:dio/dio.dart';
import 'package:ecom/di/endpoint_module.dart';
import 'package:ecom/di/repository_module.dart';
import 'package:ecom/floor/db/app_database.dart';
import 'package:ecom/network/dio_client.dart';
import 'package:get_it/get_it.dart';

import '../env/env.dart';
import 'bloc_module.dart';

final locator = GetIt.instance;

Future<void> getItInit(Env env) async {
  _setupDefaultDio(env.baseUrl, env.token);
  _databaseInit();
  await registerEndPoints();
  await registerRepositories();
  await registerBlocs();
}

void _databaseInit() {
  locator.registerLazySingleton<AppDatabase>(
          () => AppDatabase.instance);
}

void _setupDefaultDio(String baseUrl, String token) {
  locator.registerLazySingleton<Dio>(
          () => DioClient.build(baseUrl, token));
}
