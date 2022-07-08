import 'package:ecom/app/routes.dart';
import 'package:ecom/di/get_it_init.dart';
import 'package:ecom/env/env.dart';
import 'package:ecom/ui/products/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  getItInit(Env.prod());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<ProductCubit>(),
      child: MaterialApp(
        title: 'Shopping Mall',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              elevation: 0,
            )
        ),
        initialRoute: Routes.productsPage,
        onGenerateRoute: RouteGenerator.builder,
      ),
    );
  }
}
