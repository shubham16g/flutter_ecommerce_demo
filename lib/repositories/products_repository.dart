import 'package:ecom/network/network_error.dart';

import '../models/response/products_response.dart';
import '../network/endpoints/products_endpoint.dart';

class ProductsRepository {
  final ProductsEndpoint _productsEndpoint;

  ProductsRepository(this._productsEndpoint);

  Future<ProductsResponse> getProducts(int page) async {
    try {
      final response = await _productsEndpoint.getProducts(page);
      if (response.status == 200) {
        return response;
      } else {
        throw NetworkError(response.status, response.message);
      }
    } catch (obj) {
      final networkError = NetworkError.from(obj);
      return ProductsResponse.error(networkError.status, networkError.message);
    }
  }
}
