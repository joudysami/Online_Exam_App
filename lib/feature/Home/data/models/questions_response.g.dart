// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsResponse _$QuestionsResponseFromJson(Map<String, dynamic> json) =>
    QuestionsResponse(
      message: json['message'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionsResponseToJson(QuestionsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'questions': instance.questions,
    };

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['_id'] as String?,
      question: json['question'] as String?,
      type: json['type'] as String?,
      exam: json['exam'],
      subject: json['subject'],
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correct: json['correct'] as String?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'type': instance.type,
      'exam': instance.exam,
      'subject': instance.subject,
      'answers': instance.answers,
      'correct': instance.correct,
    };

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
  id: json['_id'] as String?,
  answer: json['answer'] as String?,
  key: json['key'] as String?,
);

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'answer': instance.answer,
      'key': instance.key,
    };
