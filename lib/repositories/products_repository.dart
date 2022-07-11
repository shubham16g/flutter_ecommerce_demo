

import 'package:dio/dio.dart';
import 'package:ecom/floor/daos/cart_dao.dart';
import 'package:ecom/models/request/products_request.dart';
import 'package:ecom/network/network_error.dart';

import '../models/response/products_response.dart';
import '../network/endpoints/products_endpoint.dart';

class ProductsRepository {

  final ProductsEndpoint _productsEndpoint;
  final CartDao _cartDao;

  ProductsRepository(this._productsEndpoint, this._cartDao);

  Future<ProductsResponse> getProducts(int page) async {
    try {
      final response = await _productsEndpoint.getProducts(ProductsRequest(page: page, perPage: 5));
      if(response.status == 200) {
        return response;
      } else {
        throw NetworkError(response.status, response.message);
      }
    } catch (obj) {
      final networkError = NetworkError.from(obj);
      return ProductsResponse.error(
        networkError.status,
        networkError.message
      );
    }
  }
}