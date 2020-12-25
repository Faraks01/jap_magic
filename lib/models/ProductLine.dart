import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProductLine.g.dart';

@JsonSerializable(includeIfNull: true)
class ProductLine extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final String img;
  final String name;
  final String description;
  final String image;
  final List<int> products;

  ProductLine({
    this.id,
    this.img,
    this.name,
    this.description,
    this.image,
    this.products,
  });

  factory ProductLine.fromJson(Map<String, dynamic> json) =>
      _$ProductLineFromJson(json);

  Map<String, dynamic> toJson() => _$ProductLineToJson(this);
}
