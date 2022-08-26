import 'package:ecom/models/request/products_request.dart';
import 'package:ecom/models/response/products_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'products_endpoint.g.dart';

@RestApi()
abstract class ProductsEndpoint {
  factory ProductsEndpoint(Dio dio, {String baseUrl}) = _ProductsEndpoint;

  @POST('/products')
  Future<ProductsResponse> getProducts(@Body() ProductsRequest request);
}