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
      /// Set app environment here
      future: getItInit(Env.prod()),
      builder: (context, s) {
        print(s.connectionState.toString());
          return s.connectionState == ConnectionState.done
              ? MaterialApp(
                  title: 'Shopping Mall',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    colorSchemeSeed: Colors.blue,
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.blue[300],
                    )
                  ),
                  initialRoute: Routes.productsPage,
                  onGenerateRoute: RouteGenerator.builder,
                )
              : Container(
                  color: Colors.white,
                );
        });
  }
}
