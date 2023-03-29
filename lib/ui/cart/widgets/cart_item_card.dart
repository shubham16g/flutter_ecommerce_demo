import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/cart_button.dart';
import '../../../drift/app_database.dart';
import '../bloc/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final CartItem entity;

  const CartItemCard({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
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
                      CartButton(
                          quantity: entity.quantity,
                          onAdd: (qty) {
                            BlocProvider.of<CartCubit>(context)
                                .updateCartQuantity(entity.id, qty);
                          },
                          onRemove: (qty) {
                            BlocProvider.of<CartCubit>(context)
                                .updateCartQuantity(entity.id, qty);
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
