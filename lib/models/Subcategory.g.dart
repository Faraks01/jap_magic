// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) {
  return Subcategory(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] as int,
  );
}

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
    };
