// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    tag: (json['tag'] as List)?.map((e) => e as String)?.toList(),
    ratingScore: (json['rating_score'] as num)?.toDouble(),
    amountOfFeedbacks: (json['amount_of_feedbacks'] as num)?.toDouble(),
    name: json['name'] as String,
    image: json['image'] as String,
    descriptionTitle: (json['description_title'] as num)?.toDouble(),
    description: json['description'] as String,
    barcode: json['barcode'] as String,
    price: json['price'] as String,
    brand: json['brand'] as int,
    properties: (json['properties'] as List)?.map((e) => e as int)?.toList(),
    similarProducts:
        (json['similar_products'] as List)?.map((e) => e as int)?.toList(),
    subcategories:
        (json['subcategories'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'rating_score': instance.ratingScore,
      'amount_of_feedbacks': instance.amountOfFeedbacks,
      'name': instance.name,
      'image': instance.image,
      'description_title': instance.descriptionTitle,
      'description': instance.description,
      'barcode': instance.barcode,
      'price': instance.price,
      'brand': instance.brand,
      'properties': instance.properties,
      'similar_products': instance.similarProducts,
      'subcategories': instance.subcategories,
    };
