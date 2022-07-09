import 'package:flutter/material.dart';

class PaginationGridView<T> extends StatefulWidget {
  const PaginationGridView({
    Key? key,
    required this.items,
    required this.onScrolledToBottom,
    required this.itemBuilder,
    required this.gridDelegate,
    this.loaderBuilder,
  }) : super(key: key);

  final List<T?> items;
  final VoidCallback onScrolledToBottom;
  final SliverGridDelegate gridDelegate;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context)? loaderBuilder;

  @override
  State<PaginationGridView<T>> createState() => _PaginationGridViewState();
}

class _PaginationGridViewState<T> extends State<PaginationGridView<T>> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 50) {
      widget.onScrolledToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        if (item != null) {
          return widget.itemBuilder(context, item);
        } else {
          if (widget.loaderBuilder != null) {
            return widget.loaderBuilder!(context);
          } else {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
      },
      itemCount: widget.items.length,
      controller: controller,
      gridDelegate: widget.gridDelegate,
    );
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }
}
