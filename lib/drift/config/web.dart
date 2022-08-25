import 'package:drift/web.dart';
import '../app_database.dart';

AppDatabase constructDb() {
  print('web interface created ////////////////////////////////////////////////////');
  return AppDatabase(WebDatabase('db'));
}