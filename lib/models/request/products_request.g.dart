// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsRequest _$ProductsRequestFromJson(Map<String, dynamic> json) =>
    ProductsRequest(
      page: json['page'] as int,
      perPage: json['perPage'] as int,
    );

Map<String, dynamic> _$ProductsRequestToJson(ProductsRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'perPage': instance.perPage,
    };
