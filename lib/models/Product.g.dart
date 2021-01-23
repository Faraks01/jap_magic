// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    tag: (json['tag'] as List)?.map((e) => e as String)?.toList(),
    ratingScore: (json['rating_score'] as num)?.toDouble() ?? 0,
    amountOfFeedbacks: json['amount_of_feedbacks'] as int ?? 0,
    name: json['name'] as String,
    image: json['image'] as String,
    descriptionTitle: json['description_title'] as String,
    description: json['description'] as String,
    barcode: json['barcode'] as String,
    price: json['price'] as String,
    brand: json['brand'] as int,
    properties: (json['properties'] as List)?.map((e) => e as int)?.toList(),
    similarProductsInfo: (json['similar_products_info'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, e as String),
            ))
        ?.toList(),
    propertiesPairs: (json['properties_pairs'] as List)
        ?.map((e) => (e as List)?.map((e) => e as String)?.toList())
        ?.toList(),
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
      'similar_products_info': instance.similarProductsInfo,
      'properties_pairs': instance.propertiesPairs,
      'subcategories': instance.subcategories,
    };
