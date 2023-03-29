import 'package:ecom/models/response/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  final int status;
  final String message;
  final int? totalRecord;
  final int? totalPage;
  final List<ProductEntity>? data;

  ProductsResponse(
      this.status, this.message, this.totalRecord, this.totalPage, this.data);

  ProductsResponse.error(this.status, this.message)
      : totalRecord = null,
        totalPage = null,
        data = null;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
