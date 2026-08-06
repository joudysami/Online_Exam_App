import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questions_response.g.dart';

@JsonSerializable()
class QuestionsResponse {
  final String? message;
  final List<QuestionModel>? questions;

  QuestionsResponse({this.message, this.questions});

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsResponseToJson(this);
}

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? question;
  final String? type;
  final dynamic exam;
  final dynamic subject;
  final List<AnswerModel>? answers;
  final String? correct;

  QuestionModel({
    this.id,
    this.question,
    this.type,
    this.exam,
    this.subject,
    this.answers,
    this.correct,
  });

  QuestionEntity toDomain() {
    return QuestionEntity(
      id: id ?? '',
      questionText: question ?? '',
      answers: answers?.map((a) => a.toDomain()).toList() ?? [],
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class AnswerModel {
  final String? answer;
  final String? key;

  AnswerModel({this.answer, this.key});

  AnswerEntity toDomain() {
    return AnswerEntity(
      answerText: answer ?? '',
      key: key ?? '',
    );
  }

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
