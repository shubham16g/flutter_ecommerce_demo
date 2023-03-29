import 'package:ecom/common/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/response/product_entity.dart';
import '../bloc/product_cubit.dart';

class ItemCard extends StatelessWidget {
  final ProductEntity entity;

  const ItemCard({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Center(
                    child: Image.network(
                      entity.image,
                      errorBuilder: (context, o, s) =>
                          Container(color: Colors.grey[200]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                    child: Text(
                  entity.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )),
                const SizedBox(
                  height: 5,
                ),
                Text("\$${entity.price}"),
              ],
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: CartButton(
                  quantity: entity.quantity,
                  onAdd: (qty) {
                    BlocProvider.of<ProductCubit>(context).addToCart(entity);
                  },
                  onRemove: (qty) {
                    BlocProvider.of<ProductCubit>(context)
                        .updateCartQuantity(entity.id, qty);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
