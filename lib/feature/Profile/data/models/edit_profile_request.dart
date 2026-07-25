import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  
  @JsonKey(ignore: true)
  final File? imageFile;

  EditProfileRequest({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.imageFile,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) => _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}
