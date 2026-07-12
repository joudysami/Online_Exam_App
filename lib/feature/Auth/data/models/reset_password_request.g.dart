part of 'reset_password_request.dart';

ResetPasswordRequest ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  email: json['email'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'newPassword': instance.newPassword,
};
