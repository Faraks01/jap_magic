// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['city'] as String,
    json['street'] as String,
    json['street_index'] as String,
    json['street_building'] as int,
    json['apartment'] as String,
    json['floor'] as int,
    json['porch'] as int,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'street_index': instance.streetIndex,
      'street_building': instance.streetBuilding,
      'apartment': instance.apartment,
      'floor': instance.floor,
      'porch': instance.porch,
    };
