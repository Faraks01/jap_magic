import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable(includeIfNull: true)
class Product extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final List<String> tag;

  @JsonKey(name: 'rating_score')
  final double ratingScore;

  @JsonKey(name: 'amount_of_feedbacks')
  final double amountOfFeedbacks;

  final String name;
  final String image;

  @JsonKey(name: 'description_title')
  final String descriptionTitle;

  final String description;
  final String barcode;
  final String price;
  final int brand;
  final List<int> properties;

  @JsonKey(name: 'similar_products')
  final List<int> similarProducts;

  final List<int> subcategories;

  Product(
      {this.id,
      this.tag,
      this.ratingScore,
      this.amountOfFeedbacks,
      this.name,
      this.image,
      this.descriptionTitle,
      this.description,
      this.barcode,
      this.price,
      this.brand,
      this.properties,
      this.similarProducts,
      this.subcategories});

  get intPrice {
    return double.parse(price).toInt();
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
