import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable(includeIfNull: true)
class Product extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final String img;
  final List<String> tag;
  final String name;
  final String description;
  final String barcode;
  final String price;
  final int brand;
  final List<int> subcategories;

  Product({
    this.id,
    this.img,
    this.tag,
    this.name,
    this.description,
    this.barcode,
    this.price,
    this.brand,
    this.subcategories,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
