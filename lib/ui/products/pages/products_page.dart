import 'package:ecom/app/routes.dart';
import 'package:ecom/common/utils/ui_utils.dart';
import 'package:ecom/common/widgets/pagination_grid_view.dart';
import 'package:ecom/models/response/product_entity.dart';
import 'package:ecom/ui/products/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Mall"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.pushNamed(context, Routes.cartPage);
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => locator<ProductCubit>(),
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state){
            if (state is ProductLoaded && state.error != null){
              context.showSnackbar(state.error!);
            }
          },
            builder: (context, state) {
              if (state is ProductInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductLoaded) {
                return PaginationGridView<ProductEntity>(
                  padding: const EdgeInsets.all(20),
                  items: state.products,
                  itemBuilder: (context, item) {
                    return ItemCard(entity: item);
                  },
                  onScrolledToBottom: () {},
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 270,
                    maxCrossAxisExtent: 220,
                  ),
                );
              } else if (state is ProductLoadError) {
                return  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.error, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                      const SizedBox(height: 20),
                      TextButton(onPressed: (){
                        BlocProvider.of<ProductCubit>(context).loadsProducts();
                      }, child: const Text("Retry"), style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.2))
                      ),),
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("Something went wrong"),
              );
            }),
      ),
    );
  }
}

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
        child: Column(
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
            SizedBox(height: 37,
                child: Text(entity.title, style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${entity.price}"),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  child: IconButton(
                      onPressed: () {
                        BlocProvider.of<ProductCubit>(context).addToCart(entity);
                        context.showSnackbar('Product added to cart');
                      },
                      icon: const Icon(Icons.shopping_cart)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

