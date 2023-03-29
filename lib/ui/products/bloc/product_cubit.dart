import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecom/drift/app_database.dart';
import 'package:ecom/repositories/cart_repository.dart';

import '../../../common/classes/pagination_manager.dart';
import '../../../models/response/product_entity.dart';
import '../../../repositories/products_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepository _productsRepository;
  final CartRepository _cartRepository;
  late StreamSubscription _subscription;

  ProductCubit(this._productsRepository, this._cartRepository)
      : super(ProductInitial()) {
    loadsProducts();
    _subscription = _cartRepository.allItemsStream().listen((list) {
      if (paginationManager.list.isEmpty) return;
      _updateList(list);
      emit(ProductsUpdated(paginationManager.list));
    });
  }

  void _updateList(List<CartItem> list) {
    for (int i = 0; i < paginationManager.list.length; i++) {
      int index = list
          .indexWhere((element) => element.id == paginationManager.list[i]?.id);
      if (index != -1) {
        paginationManager.list[i]?.quantity = list[index].quantity;
      } else {
        paginationManager.list[i]?.quantity = 0;
      }
    }
  }

  //this is a custom made solution for pagination handling
  final paginationManager = PaginationManager<ProductEntity>();

  Future<void> loadsProducts() async {
    if (paginationManager.list.isEmpty) {
      emit(ProductInitial());
    }
    paginationManager.startFetching(fetcher: (page) async {
      final response = await _productsRepository.getProducts(page);
      if (response.status == 200) {
        return PaginationResponse.success(
            list: response.data!, lastPage: response.totalPage!);
      } else {
        return PaginationResponse.error(
            errorCode: response.status, errorMessage: response.message);
      }
    }, successCallback: (list) async {
      _updateList(await _cartRepository.getAllItems());
      emit(ProductsUpdated(list));
    }, errorCallback: (int errorCode, String errorMessage) {
      if (paginationManager.list.isNotEmpty) {
        emit(ProductsUpdated(paginationManager.list, error: errorMessage));
      } else {
        emit(ProductLoadError(errorMessage));
      }
    });
  }

  void addToCart(ProductEntity entity) {
    _cartRepository.addToCart(entity);
  }

  void updateCartQuantity(int id, int quantity) {
    _cartRepository.updateCartQuantity(id, quantity);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
