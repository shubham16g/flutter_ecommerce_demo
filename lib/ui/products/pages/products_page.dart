import 'package:badges/badges.dart';
import 'package:ecom/app/routes.dart';
import 'package:ecom/common/utils/ui_utils.dart';
import 'package:ecom/common/widgets/pagination_grid_view.dart';
import 'package:ecom/models/response/product_entity.dart';
import 'package:ecom/ui/products/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../widgets/item_card.dart';

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
              onScrolledToBottom: () {
                BlocProvider.of<ProductCubit>(context).loadsProducts();
              },
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

