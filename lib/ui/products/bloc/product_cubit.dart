import 'package:bloc/bloc.dart';
import 'package:ecom/repositories/cart_repository.dart';

import '../../../common/classes/pagination_manager.dart';
import '../../../models/response/product_entity.dart';
import '../../../repositories/products_repository.dart';


part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepository _productsRepository;
  final CartRepository _cartRepository;
  ProductCubit(this._productsRepository, this._cartRepository) : super(ProductInitial()){
    loadsProducts();
  }

  final paginationManager = PaginationManager<ProductEntity>();

  Future<void> loadsProducts() async {
    if(paginationManager.list.isEmpty){
      emit(ProductInitial());
    }
    paginationManager.startFetching(fetcher: (page) async {
      final response = await _productsRepository.getProducts(page);
      if (response.status == 200) {
        return PaginationResponse.success(list: response.data!, lastPage: response.totalPage!);
      } else {
        return PaginationResponse.error(errorCode: response.status, errorMessage: response.message);
      }
    }, successCallback: (list){
        emit(ProductLoaded(list));
    }, errorCallback: (int errorCode, String errorMessage) {
      if(paginationManager.list.isNotEmpty){
        emit(ProductLoaded(paginationManager.list, error: errorMessage));
      } else {
        emit(ProductLoadError(errorMessage));
      }
    });
  }

  void addToCart(ProductEntity entity){
    _cartRepository.addToCart(entity);
  }
}
