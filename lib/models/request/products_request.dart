import 'package:json_annotation/json_annotation.dart';

part 'products_request.g.dart';

@JsonSerializable()
class ProductsRequest {
  final int page;
  final int perPage;
  ProductsRequest({required this.page, required this.perPage});

  factory ProductsRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsRequestToJson(this);
}
