import 'dart:async';

import 'package:ecom/floor/daos/cart_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../entities/cart_item.dart';

part 'app_database.g.dart';

@Database(version: 2, entities: [CartItem])
abstract class AppDatabase extends FloorDatabase{
  CartDao get cartDao;

  static get instance async {
    return await $FloorAppDatabase.databaseBuilder('app_database1.db').build();
  }
}

