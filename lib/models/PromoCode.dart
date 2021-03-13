import 'package:json_annotation/json_annotation.dart';

part 'PromoCode.g.dart';

enum DiscountType { ABSOLUTE, PERCENT }

@JsonSerializable(includeIfNull: true)
class PromoCode {
  final int id;
  final int value;

  @JsonKey(name: 'discount_type')
  final String $discountType;

  @JsonKey(ignore: true)
  DiscountType get discountType {
    if ($discountType == 'perc') return DiscountType.PERCENT;
    return DiscountType.ABSOLUTE;
  }

  @JsonKey(name: 'min_required_price', defaultValue: 0)
  final int minRequiredPrice;

  final String code;

  @JsonKey(name: 'valid_thru')
  final DateTime validThrough;

  final bool active;

  PromoCode(this.id, this.value, this.$discountType, this.minRequiredPrice,
      this.code, this.validThrough, this.active);

  factory PromoCode.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeToJson(this);
}
