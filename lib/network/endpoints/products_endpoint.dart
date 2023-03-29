import 'package:ecom/models/response/products_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'products_endpoint.g.dart';

@RestApi()
abstract class ProductsEndpoint {
  factory ProductsEndpoint(Dio dio, {String baseUrl}) = _ProductsEndpoint;

  @GET('/products/{page}.json')
  Future<ProductsResponse> getProducts(@Path("page") int page);
}
