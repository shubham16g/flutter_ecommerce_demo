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
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CartCubit(locator.get()),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoaded){
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        return CartItemCard(entity: item);
                      },
                    ),
                  ),
                  Container(
                    height: 55,
                    color: Colors.blue[200],
                  )
                ],
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



class CartItemCard extends StatelessWidget {
  final CartItem entity;

  const CartItemCard({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      height: 150,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Image.network(
                entity.image,
                errorBuilder: (context, o, s) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  Text(entity.title, style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price"),
                      Text("\$${entity.price}"),
                    ],
                  ),
                  SizedBox(height: 19,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity"),
                      Text("${entity.quantity}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

