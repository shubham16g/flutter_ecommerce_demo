import 'package:ecom/common/widgets/cart_button.dart';
import 'package:ecom/di/service_locator.dart';
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
        create: (context) => locator<CartCubit>(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartEmpty){
              return const Center(
                child: Text("Cart is empty"),
              );
            }
            if (state is CartLoaded) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.blue[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Items: ${state.totalItems}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Grand Total: \$${state.totalPrice}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
      padding: const EdgeInsets.only(top:8, left: 8, right: 8,),
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
      height: 157,
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
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    entity.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Price"),
                      Text("\$${entity.price}"),
                    ],
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text("Quantity")),
                      CartButton(quantity: entity.quantity, onAdd: (qty){
                        BlocProvider.of<CartCubit>(context).updateCartQuantity(entity.id, qty);
                      }, onRemove: (qty){
                        BlocProvider.of<CartCubit>(context).updateCartQuantity(entity.id, qty);
                      })
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
