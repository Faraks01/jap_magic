// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    tag: (json['tag'] as List)?.map((e) => e as String)?.toList(),
    name: json['name'] as String,
    image: json['image'] as String,
    description: json['description'] as String,
    barcode: json['barcode'] as String,
    price: json['price'] as String,
    brand: json['brand'] as int,
    subcategories:
        (json['subcategories'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'barcode': instance.barcode,
      'price': instance.price,
      'brand': instance.brand,
      'subcategories': instance.subcategories,
    };
