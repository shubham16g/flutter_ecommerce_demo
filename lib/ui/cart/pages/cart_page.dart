import 'package:ecom/di/get_it_init.dart';
import 'package:ecom/floor/entities/cart_item.dart';
import 'package:ecom/ui/cart/bloc/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CartCubit(locator.get()),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoaded){
              return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  final item = state.cartItems[index];
                  return ListTile(
                    title: InkWell(
                        child: Text(item.title),
                        onTap: () {
                          BlocProvider.of<CartCubit>(context)
                              .updateCartQuantity(
                              item.id, item.quantity + 1);
                        }),
                    trailing: Text("${item.quantity}"),
                  );
                },
              );
            }
            return const Center(
              child: Text("Error"),
            );
          },
        ),
      ),
    );
  }
}
