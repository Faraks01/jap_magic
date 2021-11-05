import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Address.g.dart';

@JsonSerializable(includeIfNull: true)
class Address extends BaseModel {
  final int id;
  final String city;
  final String street;

  @JsonKey(name: 'street_index')
  final String streetIndex;

  @JsonKey(name: 'street_building')
  final int streetBuilding;

  final String apartment;

  final int floor;

  final int porch;

  Address(this.id, this.city, this.street, this.streetIndex, this.streetBuilding,
      this.apartment, this.floor, this.porch);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
