// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductLine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLine _$ProductLineFromJson(Map<String, dynamic> json) {
  return ProductLine(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    products: (json['products'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$ProductLineToJson(ProductLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'products': instance.products,
    };
