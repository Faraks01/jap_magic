import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Subcategory.g.dart';

@JsonSerializable(includeIfNull: true)
class Subcategory extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final String name;
  final int category;

  Subcategory({
    this.id,
    this.name,
    this.category,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
