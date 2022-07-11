

import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {

  final int quantity;
  final Function(int qty) onAdd;
  final Function(int qty) onRemove;

  const CartButton({Key? key, required this.quantity, required this.onAdd, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (quantity < 1) {
      return Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: IconButton(
            onPressed: () {
              onAdd(1);
            },
            icon: const Icon(Icons.shopping_cart)),
      );
    }
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          _iconButton(Icons.remove, (){
            onRemove(quantity - 1);
          }),
          SizedBox(width: 40, child: Center(child: Text("$quantity"))),
          _iconButton(Icons.add, (){
            onAdd(quantity + 1);
          })
        ],
      ),
    );
  }

  Widget _iconButton(IconData iconData, VoidCallback onPressed)=>
      Material(
        shape: const CircleBorder(),
        color: Colors.blue[200],
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(iconData),
          ),
        ),
      );
}
