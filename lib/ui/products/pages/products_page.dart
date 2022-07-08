import 'package:ecom/common/widgets/pagination_grid_view.dart';
import 'package:ecom/models/response/product_entity.dart';
import 'package:ecom/ui/products/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            return PaginationListView<ProductEntity>(
              items: state.products,
              itemBuilder: (context, index) {
                final item = state.products[index]!;
                return ItemCard(entity: item);
              },
              onScrolledToBottom: () {},
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 220, childAspectRatio: 0.7),);
          }
          return const Center(
            child: Text("Error"),
          );
        }
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ProductEntity entity;
  const ItemCard({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(entity.image, width: 120,)),
            const SizedBox(height: 12,),
            Text(entity.title),
            Text(entity.price.toString()),
          ],
        ),
      ),
    );
  }
}

