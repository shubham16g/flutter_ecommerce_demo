import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/floor/entities/cart_item.dart';
import 'package:ecom/repositories/cart_repository.dart';

import '../../../common/classes/pagination_manager.dart';
import '../../../models/response/product_entity.dart';
import '../../../repositories/products_repository.dart';


part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  late StreamSubscription _subscription;
  CartCubit(this._cartRepository) : super(CartInitial()){
    _subscription = _cartRepository.getAllCartItems().listen((list) {
      emit(CartLoaded(list));
    });
  }


  // Stream<List<CartItem>> get cartItemStream => _cartRepository.getAllCartItems();

  void addToCart(ProductEntity entity){
    _cartRepository.addToCart(entity);
  }

  void updateCartQuantity(int id, int quantity){
    _cartRepository.updateCartQuantity(id, quantity);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


}
