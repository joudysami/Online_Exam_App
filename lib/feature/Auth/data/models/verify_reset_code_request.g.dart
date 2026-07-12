
part of 'verify_reset_code_request.dart';



VerifyResetCodeRequest _$VerifyResetCodeRequestFromJson(
  Map<String, dynamic> json,
) => VerifyResetCodeRequest(resetCode: json['resetCode'] as String);

Map<String, dynamic> _$VerifyResetCodeRequestToJson(
  VerifyResetCodeRequest instance,
) => <String, dynamic>{'resetCode': instance.resetCode};
