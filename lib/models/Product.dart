import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable(includeIfNull: true)
class Product extends BaseModel {
  final int id;
  final List<String> tag;

  @JsonKey(name: 'rating_score', defaultValue: 0)
  final double ratingScore;

  @JsonKey(name: 'amount_of_feedbacks', defaultValue: 0)
  final int amountOfFeedbacks;

  final String name;
  final String image;

  @JsonKey(name: 'description_title')
  final String descriptionTitle;

  final String description;
  final String barcode;
  final String price;
  final int brand;
  final List<int> properties;

  @JsonKey(name: 'similar_products_info')
  final List<Map<String, String>> similarProductsInfo;

  @JsonKey(name: 'properties_pairs')
  final List<List<String>> propertiesPairs;

  final List<int> subcategories;

  @JsonKey(ignore: true)
  int quantity = 1;

  @JsonKey(ignore: true)
  int get summaryPrice => quantity * intPrice;

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
      this.similarProductsInfo,
      this.propertiesPairs,
      this.subcategories});

  get intPrice {
    return double.parse(price).toInt();
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
