// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PromoCode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCode _$PromoCodeFromJson(Map<String, dynamic> json) {
  return PromoCode(
    json['id'] as int,
    json['value'] as int,
    json['discount_type'] as String,
    json['min_required_price'] as int ?? 0,
    json['code'] as String,
    json['valid_thru'] == null
        ? null
        : DateTime.parse(json['valid_thru'] as String),
    json['active'] as bool,
  );
}

Map<String, dynamic> _$PromoCodeToJson(PromoCode instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'discount_type': instance.$discountType,
      'min_required_price': instance.minRequiredPrice,
      'code': instance.code,
      'valid_thru': instance.validThrough?.toIso8601String(),
      'active': instance.active,
    };
