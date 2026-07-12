
part of 'forget_password_request.dart';


ForgetPasswordRequest _$ForgetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgetPasswordRequest(email: json['email'] as String);

Map<String, dynamic> _$ForgetPasswordRequestToJson(
  ForgetPasswordRequest instance,
) => <String, dynamic>{'email': instance.email};
