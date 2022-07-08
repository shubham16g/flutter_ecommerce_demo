// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponse _$ProductsResponseFromJson(Map<String, dynamic> json) =>
    ProductsResponse(
      json['status'] as int,
      json['message'] as String,
      json['totalRecord'] as int?,
      json['totalPage'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsResponseToJson(ProductsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'totalRecord': instance.totalRecord,
      'totalPage': instance.totalPage,
      'data': instance.data,
    };
