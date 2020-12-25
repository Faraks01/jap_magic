import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Brand.g.dart';

@JsonSerializable(includeIfNull: true)
class Brand extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final String img;
  final String name;
  final String description;
  final String image;

  Brand({
    this.id,
    this.img,
    this.name,
    this.description,
    this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}
