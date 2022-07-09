import 'package:ecom/ui/products/pages/products_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const productsPage = '/';
  static const cartPage = '/cart';
}

class RouteGenerator {
  static Widget _getMainPage(String? routeName, Object? arguments) {
    switch (routeName) {
      case Routes.productsPage:
        return ProductsPage();
      case Routes.cartPage:
        return ProductsPage();

    /* Default Page */
      default:
        return const Scaffold(
          body: Center(child: Text("404 NOT FOUND")),
        );
    }
  }

  static Route<dynamic>? builder(RouteSettings? settings) {
    if (settings == null) return null;
    Widget page = _getMainPage(settings.name, settings.arguments);
    return MaterialPageRoute(
        builder: (buildContext) => page, settings: settings);
  }

}
