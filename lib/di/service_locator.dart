
import 'package:dio/dio.dart';
import 'package:ecom/di/db_module.dart';
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
  await registerDatabase();
  await registerEndPoints();
  await registerRepositories();
  await registerBlocs();
  print('openning ');
  return null;
}

void _setupDefaultDio(String baseUrl, String token) {
  locator.registerLazySingleton<Dio>(
          () => DioClient.build(baseUrl, token));
}
