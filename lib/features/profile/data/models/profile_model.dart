import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String? id;
  final String? displayName;
  final bool? isActive;
  final bool? isConfirmed;
  final String? phoneNumber;

  @JsonKey(name: 'roles')
  final String? role;

  final String? photoUrl;

  ProfileModel({
    this.id,
    this.displayName,
    this.isActive,
    this.isConfirmed,
    this.phoneNumber,
    this.role,
    this.photoUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}