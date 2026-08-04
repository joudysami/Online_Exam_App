// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_answers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAnswersResponse _$CheckAnswersResponseFromJson(
  Map<String, dynamic> json,
) => CheckAnswersResponse(
  message: json['message'] as String?,
  correct: (json['correct'] as num?)?.toInt(),
  wrong: (json['wrong'] as num?)?.toInt(),
  total: json['total'] as String?,
);

Map<String, dynamic> _$CheckAnswersResponseToJson(
  CheckAnswersResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'correct': instance.correct,
  'wrong': instance.wrong,
  'total': instance.total,
};
