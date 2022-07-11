import 'package:badges/badges.dart';
import 'package:ecom/app/routes.dart';
import 'package:ecom/common/utils/ui_utils.dart';
import 'package:ecom/common/widgets/cart_button.dart';
import 'package:ecom/common/widgets/pagination_grid_view.dart';
import 'package:ecom/models/response/product_entity.dart';
import 'package:ecom/ui/products/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProductCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Mall"),
          centerTitle: true,
          actions: [
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return IconButton(
                  icon: Badge(
                      badgeColor: Colors.white,
                      badgeContent: state is ProductsUpdated
                          ? Text(
                              state.products
                                  .fold<int>(
                                      0,
                                      (sum, product) =>
                                          sum + (product?.quantity ?? 0))
                                  .toString(),
                              style: const TextStyle(fontSize: 12),
                            )
                          : null,
                      showBadge: state is ProductsUpdated &&
                          state.products.fold<int>(
                                  0,
                                  (sum, product) =>
                                      sum + (product?.quantity ?? 0)) >
                              0,
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cartPage);
                  },
                );
              },
            ),
            const SizedBox(
              width: 4,
            )
          ],
        ),
        body: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
          if (state is ProductsUpdated && state.error != null) {
            context.showSnackbar(state.error!);
          }
        }, builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsUpdated) {
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
                mainAxisExtent: 285,
                maxCrossAxisExtent: 220,
              ),
            );
          } else if (state is ProductLoadError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ProductCubit>(context).loadsProducts();
                    },
                    child: const Text("Retry"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.blue.withOpacity(0.2))),
                  ),
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

  @override
  void initState() {
    super.initState();
    print('init called');
    // locator<ProductCubit>().loadsProducts();
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

