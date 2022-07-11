import 'package:ecom/app/routes.dart';
import 'package:ecom/di/service_locator.dart';
import 'package:ecom/env/env.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: getItInit(Env.prod()),
      builder: (context, s) {
          return s.connectionState == ConnectionState.done
              ? MaterialApp(
                  title: 'Shopping Mall',
                  theme: ThemeData(
                    splashFactory: InkRipple.splashFactory,
                      primarySwatch: Colors.blue,
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Color(0xFF6493FF),
                        elevation: 0,
                      )),
                  initialRoute: Routes.productsPage,
                  onGenerateRoute: RouteGenerator.builder,
                )
              : Container(
                  color: Colors.white,
                );
        });
  }
}
