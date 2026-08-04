// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_answers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAnswersRequest _$CheckAnswersRequestFromJson(Map<String, dynamic> json) =>
    CheckAnswersRequest(
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerItemRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: (json['time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckAnswersRequestToJson(
  CheckAnswersRequest instance,
) => <String, dynamic>{'answers': instance.answers, 'time': instance.time};

AnswerItemRequest _$AnswerItemRequestFromJson(Map<String, dynamic> json) =>
    AnswerItemRequest(
      questionId: json['questionId'] as String,
      correct: json['correct'] as String,
    );

Map<String, dynamic> _$AnswerItemRequestToJson(AnswerItemRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'correct': instance.correct,
    };
