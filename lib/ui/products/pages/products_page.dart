import 'package:ecom/common/widgets/pagination_grid_view.dart';
import 'package:ecom/models/response/product_entity.dart';
import 'package:ecom/ui/products/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/get_it_init.dart';

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
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: ProductCubit(locator.get()),
        builder: (context, state) {
        if (state is ProductInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoaded) {
          return PaginationGridView<ProductEntity>(
            items: state.products,
            itemBuilder: (context, item) {
              return ItemCard(entity: item);
            },
            onScrolledToBottom: () {},
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 270,
              maxCrossAxisExtent: 220,
            ),
          );
        }
        return PaginationGridView<ProductEntity>(
          items: [
            ProductEntity(
                id: 1,
                slug: 'slug',
                title: 'title',
                description: 'description',
                image: 'image',
                price: 98,
                status: 'status',
                createdAt: 'createdAt'),
            ProductEntity(
                id: 1,
                slug: 'slug',
                title: 'title',
                description: 'description',
                image: 'image',
                price: 98,
                status: 'status',
                createdAt: 'createdAt'),
            ProductEntity(
                id: 1,
                slug: 'slug',
                title: 'title',
                description: 'description',
                image: 'image',
                price: 98,
                status: 'status',
                createdAt: 'createdAt'),
            ProductEntity(
                id: 1,
                slug: 'slug',
                title: 'title',
                description: 'description',
                image: 'image',
                price: 98,
                status: 'status',
                createdAt: 'createdAt'),
          ],
          itemBuilder: (context, item) {
            return ItemCard(entity: item);
          },
          onScrolledToBottom: () {},
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            mainAxisExtent: 270,
            maxCrossAxisExtent: 220,
          ),
        );
      }),
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
            SizedBox(height: 37, child: Text(entity.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${entity.price}"),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductCubit>(context).addToCart(entity);
                    },
                    icon: const Icon(Icons.shopping_cart)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

