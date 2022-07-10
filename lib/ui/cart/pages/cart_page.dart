import 'package:ecom/di/get_it_init.dart';
import 'package:ecom/floor/entities/cart_item.dart';
import 'package:ecom/repositories/cart_repository.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<CartItem>>(
          stream: locator.get<CartRepository>().getAllCartItems(),
          builder: (context, s) {
            final list = s.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                final item = list[index];
                return ListTile(
                  title: InkWell(
                      child: Text(item.title),
                      onTap: () {
                        locator
                            .get<CartRepository>()
                            .updateCartQuantity(item.id, item.quantity + 1);
                      }),
                  trailing: Text('${item.quantity}'),
                );
              },
              itemCount: list.length,
            );
          }),
    );
  }
}
