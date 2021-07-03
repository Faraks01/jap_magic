import 'package:json_annotation/json_annotation.dart';

import 'package:jap_magic/models/interfaces/BaseModel.dart';

part 'User.g.dart';

@JsonSerializable(includeIfNull: true)
class User extends BaseModel {
  // @JsonKey(name: 'example_field')
  final int id;
  final String username;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String email;

  @JsonKey(name: 'has_verified_email')
  final bool hasVerifiedEmail;

  @JsonKey(name: 'has_verified_phone')
  final bool hasVerifiedPhone;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final String phone;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.hasVerifiedEmail,
    this.hasVerifiedPhone,
    this.isActive,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
