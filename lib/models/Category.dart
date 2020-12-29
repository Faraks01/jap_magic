import 'package:json_annotation/json_annotation.dart';

import 'package:jap_magic/models/interfaces/BaseModel.dart';

part 'Category.g.dart';

@JsonSerializable(includeIfNull: true)
class Category extends BaseModel {
  final int id;
  final String name;
  final String image;
  final String description;

  @JsonKey(name: 'short_image')
  final String shortImage;

  Category({
    this.id,
    this.name,
    this.image,
    this.shortImage,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
