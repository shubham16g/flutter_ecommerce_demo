// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      id: json['id'] as int,
      slug: json['slug'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['featured_image'] as String,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'featured_image': instance.image,
      'price': instance.price,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
