import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable(includeIfNull: true)
class Product extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final List<String> tag;
  final String name;
  final String image;
  final String description;
  final String barcode;
  final String price;
  final int brand;
  final List<int> subcategories;

  Product({
    this.id,
    this.tag,
    this.name,
    this.image,
    this.description,
    this.barcode,
    this.price,
    this.brand,
    this.subcategories,
  });

  get intPrice {
    return double.parse(price).toInt();
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
