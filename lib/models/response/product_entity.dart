
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  final int id;
  String slug;
  final String title, description;
  @JsonKey(name: 'featured_image')
  final String image;
  final double price;
  final String status;
  @JsonKey(name: "created_at")
  String? createdAt;

  ProductEntity(
      {required this.id,
        required this.slug,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.status,
      required this.createdAt});

  factory ProductEntity.fromJson(Map<String, dynamic> json) => _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}