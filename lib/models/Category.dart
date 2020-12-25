import 'package:json_annotation/json_annotation.dart';

import 'package:jap_magic/models/interfaces/BaseModel.dart';

part 'Category.g.dart';

@JsonSerializable(includeIfNull: true)
class Category extends BaseModel {
  final int id;
  final String img;
  final String name;
  final String image;
  final String description;

  Category({
    this.id,
    this.img,
    this.name,
    this.image,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
