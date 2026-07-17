import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String? message;
  final String? token;
  final UserDto? user;

  AuthResponse({
    this.message,
    this.token,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class UserDto {
  final String? id;
  @JsonKey(name: 'username', defaultValue: '')
  final String? username;
  @JsonKey(name: 'firstName', defaultValue: '')
  final String? firstName;
  @JsonKey(name: 'lastName', defaultValue: '')
  final String? lastName;
  final String? email;
  final String? phone;

  UserDto({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
