// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) {
  return Brand(
    id: json['id'] as int,
    img: json['img'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
